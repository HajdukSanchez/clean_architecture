# Trivia App

A flutter project to explain clean architecture behavior.

This project was created using Clean Architecture and TDD.

Follow my work: [https://hajduk-sanchez.com]()

## Getting Started

We use a feature folder structure and a core directory to transversal process in the app.

We also added a test directory structure similar as the features to handle the TDD.

### lib directory structure

```
📦lib
 ┣ 📂core
 ┃ ┣ 📂error
 ┃ ┃ ┣ 📜exceptions.dart
 ┃ ┃ ┗ 📜failures.dart
 ┃ ┣ 📂network
 ┃ ┃ ┗ 📜network_info.dart
 ┃ ┣ 📂routes
 ┃ ┃ ┗ 📜routes.dart
 ┃ ┣ 📂usecases
 ┃ ┃ ┗ 📜usecase.dart
 ┃ ┗ 📂util
 ┃ ┃ ┗ 📜input_converter.dart
 ┣ 📂features
 ┃ ┗ 📂number_trivia
 ┃ ┃ ┣ 📂data
 ┃ ┃ ┃ ┣ 📂datasources
 ┃ ┃ ┃ ┃ ┣ 📜number_trivia_local_data_source.dart
 ┃ ┃ ┃ ┃ ┗ 📜number_trivia_remote_data_source.dart
 ┃ ┃ ┃ ┣ 📂models
 ┃ ┃ ┃ ┃ ┗ 📜number_trivia_model.dart
 ┃ ┃ ┃ ┗ 📂repositories
 ┃ ┃ ┃ ┃ ┗ 📜number_trivia_repository_impl.dart
 ┃ ┃ ┣ 📂domain
 ┃ ┃ ┃ ┣ 📂entities
 ┃ ┃ ┃ ┃ ┗ 📜number_trivia.dart
 ┃ ┃ ┃ ┣ 📂repositories
 ┃ ┃ ┃ ┃ ┗ 📜number_trivia_repository.dart
 ┃ ┃ ┃ ┗ 📂usecases
 ┃ ┃ ┃ ┃ ┣ 📜get_number_trivia.dart
 ┃ ┃ ┃ ┃ ┗ 📜get_random_number_trivia.dart
 ┃ ┃ ┗ 📂presentation
 ┃ ┃ ┃ ┣ 📂bloc
 ┃ ┃ ┃ ┃ ┣ 📜number_trivia_bloc.dart
 ┃ ┃ ┃ ┃ ┣ 📜number_trivia_event.dart
 ┃ ┃ ┃ ┃ ┗ 📜number_trivia_state.dart
 ┃ ┃ ┃ ┣ 📂pages
 ┃ ┃ ┃ ┃ ┗ 📜number_trivia_page.dart
 ┃ ┃ ┃ ┗ 📂widgets
 ┃ ┃ ┃ ┃ ┣ 📜trivia_button.dart
 ┃ ┃ ┃ ┃ ┣ 📜trivia_information.dart
 ┃ ┃ ┃ ┃ ┣ 📜trivia_input_text.dart
 ┃ ┃ ┃ ┃ ┣ 📜trivia_loading_progress.dart
 ┃ ┃ ┃ ┃ ┗ 📜widgtes.dart
 ┣ 📜injection_container.dart
 ┗ 📜main.dart
```


### test directory structure
```
📦test
 ┣ 📂core
 ┃ ┣ 📂network
 ┃ ┃ ┗ 📜network_info_test.dart
 ┃ ┗ 📂util
 ┃ ┃ ┗ 📜input_converter_test.dart
 ┣ 📂features
 ┃ ┗ 📂number_trivia
 ┃ ┃ ┣ 📂data
 ┃ ┃ ┃ ┣ 📂datasources
 ┃ ┃ ┃ ┃ ┣ 📜number_trivia_local_data_source_test.dart
 ┃ ┃ ┃ ┃ ┗ 📜number_trivia_remote_data_source_test.dart
 ┃ ┃ ┃ ┣ 📂models
 ┃ ┃ ┃ ┃ ┗ 📜number_trivia_model_test.dart
 ┃ ┃ ┃ ┗ 📂respositories
 ┃ ┃ ┃ ┃ ┗ 📜number_trivia_repository_impl_test.dart
 ┃ ┃ ┣ 📂domain
 ┃ ┃ ┃ ┗ 📂usecases
 ┃ ┃ ┃ ┃ ┣ 📜get_number_trivia_test.dart
 ┃ ┃ ┃ ┃ ┗ 📜get_random_number_trivia_test.dart
 ┃ ┃ ┗ 📂presentation
 ┃ ┃ ┃ ┗ 📂bloc
 ┃ ┃ ┃ ┃ ┗ 📜number_trivia_bloc_test.dart
 ┗ 📂fixtures
 ┃ ┣ 📜fixture_reader.dart
 ┃ ┣ 📜trivia.json
 ┃ ┣ 📜trivia_cached.json
 ┃ ┗ 📜trivia_double.json
```

## Here is the final version of the app

<div style="display: flex; felx-direction:row;">
  <img src="https://user-images.githubusercontent.com/76627513/178070999-840ff028-e688-4552-a4b0-53aa2588371f.png" alt="drawing" width="200"/>
  <img src="https://user-images.githubusercontent.com/76627513/178071006-6b72763f-15bd-444d-be02-cba9b1e93a22.png" alt="drawing" width="200"/>
  <img src="https://user-images.githubusercontent.com/76627513/178071008-c8dfd95c-a1a8-41b6-9e97-6fc9ffc5df18.png" alt="drawing" width="200"/>
</div>
