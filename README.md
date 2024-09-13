# Quiz Master - ReScript, React, OpenAI Integration

## Description
Quiz Master est une application de quiz interactive où l'utilisateur peut choisir parmi différents thèmes, générer des questions sur le sujet choisi, et répondre de manière vocale grâce à l'API Web Speech. L'application est développée avec ReScript pour le backend et React pour le frontend, et utilise OpenAI pour générer les questions du quiz.

## Fonctionnalités
- **Choix des thèmes :** Les utilisateurs peuvent sélectionner un thème depuis l'interface.
- **Génération de quiz :** Un quiz est automatiquement généré sur le thème sélectionné via l'intégration d'OpenAI.
- **Réponses vocales :** L'utilisateur peut répondre aux questions par la voix grâce à l'API Web Speech du navigateur.
- **Système de score :** Le score est calculé en fonction de la progression de l'utilisateur dans le quiz, avec un système d'élimination après une erreur.

## Prérequis
- **Node.js** (v14+ recommandé)
- **ReScript** (installé via `npm`)
- **React** (v17+ recommandé)
- **OpenAI API key** pour générer des questions

## Installation

1. Clonez le projet :
   ```bash
   git clone https://github.com/Nairod36/ReScript-Project
   cd quiz-master
2. Installez les dépendances :
   ```bash
   npm install
3. Configurez votre clé API OpenAI :

  Créez un fichier .env à la racine du projet avec la clé OpenAI :
  OPENAI_API_KEY=your_openai_api_key

4. Compilez le code ReScript :

5. Lancez le serveur :

## Utilisation
1. **Lancement de l'application :** Une fois le serveur lancé, accédez à l'application sur `http://localhost:3000`.
2. **Choisissez un thème :** Sur la page d'accueil, sélectionnez un thème pour commencer le quiz.
3. **Répondez aux questions :** Répondez aux questions en utilisant votre voix ou en saisissant votre réponse.
4. **Visualisez votre score :** À chaque bonne réponse, vous avancez dans le quiz et votre score s'affiche à l'écran.

## Technologies utilisées
- **Backend :** ReScript, Express, OpenAI API
- **Frontend :** React
- **API vocale :** Web Speech API

## Licence
Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

