# Mas informacion acerca de otras integraciones del Broker 

# 1. Baja la imagen correcta de docker

docker pull snyk/broker:gitlab

# 2. Saca la imagen de code-agent para habilitar la funcion del escaneo SAST

docker pull snyk/code-agent

# 3. Genera un network privado para correr ambos el Broker client y el code agent. En este ejemplo el mio se llama mySnykBrokerNetwork

docker network create mySnykBrokerNetwork

# 4. Ahora verifica que tienes el archivo accept.json encontrado en esta pagina (https://gist.github.com/akanchhaS/7911f22204178a422a7d48d0f85fbdb4#file-accept-json) guardado en tu maquina local en este typo de directorio privado /home/private para poderlo connectar con el contenedor. Asegurate de tener la version correcta del accept.json porque cada integracion tiene su propio accept.json

# 5. Corre el contenedor

docker run --restart=always \           
           -p 8000:8000 \
           -e BROKER_TOKEN=<YOUR-BROKER-TOKEN> \
           -e GITLAB_TOKEN=<YOUR-GITLAB-TOKEN> \
           -e GITLAB=<YOUR-GITLAB-HOSTNAME> \
           -e BROKER_CLIENT_URL=http://my.broker.client:8000 \
           -e PORT=8000 \
           -e ACCEPT=/private/accept.json -v /path/on/local/private:/private \
           -e GIT_CLIENT_URL=http://code-agent:3000 \
           --network mySnykBrokerNetwork \
       snyk/broker:gitlab 
       
# BROKER_TOKEN: este token esta encontrado en la plataforma de snyk, puede ser extraido mediante el API o puede ser encontrado en la plataforma UI (para mas informacion https://docs.snyk.io/integrations/snyk-broker/snyk-broker-code-agent/setting-up-the-code-agent-broker-client-deployment/step-1-obtaining-the-required-tokens-for-the-setup-procedure/obtaining-your-broker-token)
