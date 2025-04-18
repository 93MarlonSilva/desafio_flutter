# Quiz Challenge

Este é um projeto de quiz desenvolvido em Flutter, com foco em uma arquitetura limpa e separação entre regras de negócio e UI.

Foram utilizados pacotes compatíveis com múltiplas plataformas, com o intuito de não limitar a aplicação. Além das versões para Android e iOS, também foi gerado o build da versão web, sugestão do desenvolvedor.

## 📐 Arquitetura

**MVVM (Model - View - ViewModel)**  
**Motivo:**  
A arquitetura MVVM é ideal para aplicações pequenas como essa, pois promove a separação entre lógica de negócios e lógica de interface de usuário de forma clara e eficiente.


## 🔄 Gerenciamento de Estado

**ChangeNotifier**  
**Motivo:**  
O `ChangeNotifier` atende bem às necessidades de um projeto pequeno, mantendo a simplicidade sem abrir mão da capacidade de gerenciar estados de maneira eficaz.


## 💾 Armazenamento de Dados

- **SharedPreferences:**  
  Utilizado para armazenar o maior score de forma simples, no formato chave-valor.

- **Drift:**  
  Escolhido como banco de dados local por ser multiplataforma, possuir suporte avançado e ser um Flutter Favorite.  
  - `sqflite`: Não é compatível com web, caso posteriormente queira rodar a aplicação da web.  
  - `sqlite3`: Não está na lista de Flutter Favorites.  
  - `Hive`: Também não é Flutter Favorite.  
  O Drift foi minha escolha para este , tendo análisado rápidez, status do pacote e necessidades da aplicação.


## 💬 Linguagem do Código

**Inglês**  
**Motivo:**  
Para demonstrar que posso escrever código em inglês ou português, conforme o padrão do projeto.


## 🚀 Como rodar o projeto

### ✅ Acesse online

Você pode acessar o projeto diretamente na web pelo link:  
> [link do projeto web aqui] *(substitua pelo link real se quiser)*


Com o projeto aberto no VS Code, Android Studio ou Xcode, execute os seguintes comandos:

#### Web 

```bash
flutter pub get
flutter run web

🖥 Emulador ou dispositivo físico
#### Android 
```bash
flutter pub get
flutter run android

#### Ios 
flutter pub get
flutter run ios
