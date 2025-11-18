# Desafio Técnico: SpaceX Launch Tracker (Flutter)

## Contexto

Este é um aplicativo Flutter que consome a API pública da SpaceX (r/SpaceX API) para listar os próximos lançamentos de foguetes, exibir seus detalhes e mostrar um contador regressivo.

O foco é a modelagem de dados complexos com tipos de dados variados (URLs, Timestamps) e a reatividade na apresentação de tempo (contagem regressiva).

## 🚀 Requisitos Funcionais

1.  **Listagem de Próximos Lançamentos:**
    * Exibir uma lista de lançamentos futuros, ordenada pela data.
    * Cada item deve mostrar: Nome da Missão, Data de Lançamento e Foguete.
2.  **Tela de Detalhes:**
    * Ao clicar, exibir informações mais ricas: Pôster da missão, Descrição, Foguete usado, Local de Lançamento.
3.  **Contador Regressivo (Bônus/Requisito Sênior):**
    * Exibir a contagem regressiva para a data de lançamento na tela de detalhes.
    * A UI deve ser atualizada a cada segundo.

## 🛠️ Tecnologias Utilizadas

* **Flutter (SDK)**
* **Provider** (Gerenciamento de Estado)
* **http** (API REST)
* **intl** (Formatação de Data e Hora)

## 🎯 Objetivos de Aprendizado (Clean Architecture)

* **Transformação de Dados:** Conversão de Timestamps Unix (`int`) para `DateTime` (`dart:core`) na camada de `Model`.
* **Tempo Reativo:** Uso de `Timer` em Dart para atualizar o estado da UI (Contagem Regressiva) a cada segundo no `Provider`.
* **Modelagem de Relacionamento Simples:** Lançamentos se referem a `Rocket`s (que estão aninhados no JSON).

## Endpoint Principal (SpaceX API)

* `GET https://api.spacexdata.com/v4/launches/upcoming`
