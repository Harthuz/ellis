# Etapa 1: Use uma imagem Python oficial e estável. A tag 'slim' é uma boa escolha por ser menor.
FROM python:3.11-slim

# Etapa 2: Defina o diretório de trabalho dentro do contêiner
WORKDIR /app

# Etapa 3: Defina variáveis de ambiente para boas práticas em Python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Etapa 4: Copie o arquivo de dependências e instale-as
# Fazer isso em uma etapa separada aproveita o cache do Docker.
# As dependências só serão reinstaladas se o requirements.txt mudar.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copie o restante do código da sua aplicação
COPY . .

# Etapa 6: Exponha a porta em que o Uvicorn será executado
EXPOSE 8000

# Etapa 7: Comando para iniciar a aplicação com Uvicorn
# O arquivo principal é 'app.py' e o objeto da aplicação é 'app'.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]