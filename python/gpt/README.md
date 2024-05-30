# FuturaGPT

Testes de GPT com base de conhecimento

## 1. Teste Inicial - `futura_gpt.py`

Este projeto é um script Python que utiliza a API OpenAI para responder a perguntas com base em informações extraídas de uma página da web específica. O script faz o seguinte:

1. Carrega as credenciais da API OpenAI do arquivo `.env`.
2. Define uma função `calculate_tokens` para calcular o número de tokens em uma string usando a biblioteca `tiktoken`.
3. Define uma função `do_completion` para fazer uma solicitação de conclusão à API OpenAI usando o modelo `text-davinci-003`.
4. Define uma função `do_context` para extrair o contexto de uma URL usando a biblioteca `requests` e `BeautifulSoup`. O contexto inclui o título da página, o título do conteúdo e o conteúdo da página.
5. Combina o contexto e a pergunta fornecida em um prompt formatado.
6. Chama a função `do_completion` com o prompt para obter a resposta da API OpenAI.
7. Imprime a resposta no terminal.

### 1.1 Uso

Para usar o script, certifique-se de ter as bibliotecas necessárias instaladas e suas credenciais da API OpenAI no arquivo `.env`. Em seguida, execute o script no terminal. Ele irá extrair informações de uma URL específica e responder a uma pergunta com base nessas informações usando a API OpenAI.

```python
python futura_gpt.py
```

### 1.2 Análise de Resultados

A API OpenAI não é capaz de responder a perguntas que exigem um contexto muito longo. Nesse caso, a API retornará um erro. Para contornar este problema, devemos criar uma forma de deixar o contexto mais curto. Sugestões para solução deste problema:

- Criação e preparação de uma base de cohhecimento padronizada para o GPT. Exemplo:

## 2. Teste de Sumarização - `futura_sumarize.py`

A criação de uma base de conhecimento padronizada é essencial para garantir que as informações sejam facilmente acessíveis e compreensíveis. A sumarização automática de textos pode desempenhar um papel importante neste processo, ajudando a gerar resumos concisos e informativos dos documentos e melhorando a eficiência na recuperação de informações. Além disso, a sumarização pode ser útil em várias aplicações, como sistemas de recomendação, análise de sentimentos e monitoramento de notícias.

Com base na motivação de criar um sistema de padronização para as bases de conhecimento, conduzimos testes utilizando o modelo T5 para explorar suas capacidades de sumarização e identificar áreas de melhoria.

Nós realizamos os seguintes passos no código futura_sumarize.py:

1. Importa as bibliotecas necessárias, como a biblioteca transformers;
2. Carrega o modelo T5 e seu tokenizer;
3. Define uma função summarize que utiliza o modelo T5 para gerar um resumo do texto fornecido;
4. Chama a função summarize com um exemplo de texto e imprime o resumo gerado.

### 2.1 Uso

Para utilizar o script futura_sumarize.py, certifique-se de ter as bibliotecas necessárias instaladas e execute o script no terminal.

```python
python futura_sumarize.py
```

### 2.2 Análise de Resultados

E, durante nossos testes, observamos que:

- O resumo gerado contém algumas palavras truncadas ou não interpretadas corretamente;
- A coesão e a clareza do resumo gerado podem ser melhoradas;
- A quantidade de tokens e o tempo de execução são fatores importantes a serem considerados ao ajustar o processo de sumarização;
- A abordagem atual pode ser aprimorada dividindo o texto em parágrafos e gerando resumos para cada parágrafo separadamente;
- Os tokens "\<pad\>" e "\</s\>" presentes no resumo gerado podem ser removidos para melhorar a legibilidade.

---
Sugestões de melhorias e novas ideias são sempre bem-vindas.
