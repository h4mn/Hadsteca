# Author: Hadston Nunes
# Sumarização de texto com o modelo T5

# Importação de bibliotecas
import time
from transformers import T5ForConditionalGeneration, T5Tokenizer

# Texto para sumarização
text = """
Grandes modelos de linguagem demonstraram excelente desempenho em uma ampla gama de tarefas, como perguntas atendimento e geração de código. Em um alto nível, dado um input, um modelo de linguagem pode ser usado para automaticamente complete a sequência de uma maneira estatisticamente provável. Com base nisso, os usuários solicitam esses modelos com linguagem instruções ou exemplos, para implementar uma variedade de tarefas a jusante. Métodos avançados de solicitação podem até mesmo implica interação entre o modelo de linguagem, um usuário e ferramentas externas, como calculadoras. No entanto, para obter desempenho de ponta ou adaptar modelos de linguagem para tarefas específicas, tarefas complexas e específicas do modelo programas precisam ser implementados, o que ainda pode exigir interação ad hoc.

Com base nisso, apresentamos a nova ideia de Language Model Programming (LMP). LMP generaliza a linguagem solicitação de modelo de prompts de texto puro para uma combinação intuitiva de prompts de texto e scripts. Além disso, o LMP permite que as restrições sejam especificadas na saída do modelo de linguagem. Isso permite uma fácil adaptação a muitas tarefas enquanto abstrai os internos do modelo de linguagem e fornece semântica de alto nível.

Para habilitar o LMP, implementamos o LMQL (abreviação de Language Model Query Language), que aproveita o restrições e fluxo de controle de um prompt LMP para gerar um procedimento de inferência eficiente que minimiza o número de chamadas caras para o modelo de linguagem subjacente.

Mostramos que o LMQL pode capturar uma ampla variedade de métodos de solicitação de última geração de maneira intuitiva, especialmente facilitando fluxos interativos que são difíceis de implementar com APIs de alto nível existentes. Nosso avaliação mostra que mantemos ou aumentamos a precisão em várias tarefas posteriores, ao mesmo tempo em que reduzindo a quantidade necessária de computação ou custo no caso de APIs pagas para usar (economia de custos de 26 a 85%).
"""

start = time.time()

# Configuração do modelo
model_name = 't5-small'
tokenizer = T5Tokenizer.from_pretrained(model_name)
model = T5ForConditionalGeneration.from_pretrained(model_name)

# Divisão do texto em parágrafos
paragrafos = text.split("\n\n")

# Processando cada parágrafo
saidas = []
for paragrafo in paragrafos:
    prompt = f"summarize: {paragrafo}"
    input = tokenizer.encode(prompt, return_tensors="pt", max_length=512, truncation=True)
    output = model.generate(input, max_length=150, min_length=40, length_penalty=1.0, num_beams=4, early_stopping=True)
    saidas.append(output)

# Juntando os parágrafos
resumo = [tokenizer.decode(saida[0]) for saida in saidas]
resumo_combinado = "\n\n".join(resumo)
print(f"Resumo:\n{resumo_combinado}")

# Contagem de tokens
tokens = tokenizer.tokenize(text)
tokens_count = len(tokens)
print(f"Quantidade de tokens: {tokens_count}")

print(f"Tempo de execução: {time.time() - start}")

# Resultado para análise
resultado = """
Resumo:
<pad> os usuários solicitam esses modelos com linguagem instruç<unk> es ou exemplos, para implementar uma variedade de tarefas a jusante. no entanto, para obter desempenho de ponta ou adaptar modelos de linguagem para tarefas espec<unk> ficas, tarefas complexas</s>

<pad> nova ideia de Language Model Programming (LMP) permite que as restriç<unk> es sejam especificadas na sa<unk> da do modelo de linguagem.</s>

<pad> o LMP implementamos o LMQL (abreviaç<unk> o de Language Model Query Language), que aproveita o restriç<unk> es e fluxo de controle de um prompt LMP para gerar um procedimento de inferência eficiente que minimiza o n<unk> mero de chamadas caras para o modelo de linguagem subjacente.</s>

<pad> mostramos que o LMQL pode capturar uma ampla variedade de métodos de solicitaç<unk> o de <unk> ltima geraç<unk> o de maneira intuitiva. especialmente facilitando fluxos interativos que s<unk> o dif<unk> ceis de implementar com APIs de alto n<unk> vel existentes.</s>
Quantidade de tokens: 872
Tempo de execução: 11.899607181549072
"""
