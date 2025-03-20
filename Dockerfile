# Imagem base, utilizada como base de todo o container. Sempre utilizar a imagem versionada, para evitar quebra da imagem do projeto. Ex: Supondo que no momento da criação do Dockerfile, o latest do python3 é 3.10.12, mas após um tempo surge o python:4 atual latest. Isso causará quebra na imagem e no funcionamento do sistema.
FROM python:3.10.12

# Cria e acessa o diretorio, WORKDIR funciona da mesma forma que “mkdir” + “cd”, cria e ja acessa o diretório.
WORKDIR "/app"

# Copia apenas o arquivo que contém as dependências do projeto. Isso é feito pois copiando as dependencias antes, melhora o sistema de CACHE do docker, só irá iniciar o comando daqui pra baixo se for alterada alguma dependência. O comando “.” diz que é para copiar o arquivo para o diretório atual.  
COPY requirements.txt .

# Instala as dependências do projeto. Esse comando é rodado em tempo de construção da imagem.
RUN pip install -r requirements.txt
 
# Após instalar as dependências, copia o restante dos arquivos do projeto. O primeiro destino se refere ao diretório em que o Dockerfile está (origem), ja o segundo destino se refere ao diretorio atual em que esta no Dockerfile "/app".
COPY . .

# Comandos utilizados para rodar o container.
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]