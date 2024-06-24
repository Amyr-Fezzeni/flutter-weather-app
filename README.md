# Application météo créée avec Flutter

## Description
Cette application Météo pour Android et iOS permet de suivre les conditions météorologiques actuelles et les prévisions pour plusieurs villes. Elle inclut des fonctionnalités telles que le support du mode sombre et clair, plusieurs langues, et de nombreuses options de configuration et de gestion.

![Weather App](assets/animations/app_mockup.gif)
## Fonctionnalités

### Mode d'affichage
- **Mode sombre, mode clair et mode système**: L'application s'adapte automatiquement aux préférences de thème de votre système. Vous pouvez également choisir manuellement entre le mode sombre et le mode clair.

### Support de la langue
- **Anglais et Français**: L'application supporte deux langues : anglais et français. Vous pouvez changer la langue dans les paramètres de l'application.

### Configuration des unités
- **Température**: Choisissez entre Celsius et Fahrenheit.
- **Pression atmosphérique**: Options disponibles en mb (Millibars), inHg (pouces de mercure) et atm (Atmosphères standards).
- **Vitesse du vent**: Options disponibles en km/h, mph, ft/s, kt et m/s.

### Permissions de localisation
- **Demande de permission**: Lors de l'ouverture de l'application, elle demande la permission d'accéder à votre localisation. Si accordée, elle récupère les données météo basées sur votre position actuelle.

### Stockage local
- **Utilisation de Hive**: L'application utilise Hive pour stocker les paramètres de l'application et les données météo. Ainsi, les données sont disponibles même sans accès à Internet.

### Recherche et ajout de villes
- **Recherche de villes**: Vous pouvez rechercher et ajouter plusieurs villes pour suivre leurs conditions météorologiques.
- **Gestion des villes sauvegardées**: Vous pouvez supprimer des villes sauvegardées ou réorganiser l'ordre des villes selon vos préférences.

### Écran d'accueil
- **Données de votre localisation**: L'écran d'accueil affiche les informations météorologiques pour votre localisation actuelle ainsi que pour toutes les localisations enregistrées.
Pour passer d'une localisation à l'autre, vous pouvez faire glisser l'écran vers la gauche ou vers la droite.

  - Température actuelle
  - Prévisions à 5 jours
  - Données horaires (toutes les 3 heures)
  - Vitesse et direction du vent
  - Humidité
  - Température ressentie
  - Pression atmosphérique
  - Prochain lever/coucher de soleil
  - Visibilité
- **Navigation entre les localisations**: Pour passer d'une localisation à l'autre, vous pouvez faire glisser l'écran vers la gauche ou vers la droite.

### Animations météorologiques
- **Animations de neige et de pluie**: Basées sur les conditions météorologiques, des animations de neige et de pluie couvrent la totalité de l'écran, ajoutant une dimension visuelle immersive.

## Installation

1. **Cloner le Répertoire**: Clonez le répertoire Git contenant l'application.
    ```sh
    git clone <repository-url>
    ```

2. **Configuration API**: Inscrivez-vous à l'[API OpenWeather](https://openweathermap.org/api/one-call-api) pour obtenir une clé API. Ajoutez cette clé dans votre fichier de configuration.

## Utilisation

1. **Exécuter l'Application**: Utilisez la commande suivante pour exécuter l'application sur un simulateur ou un appareil physique.
    ```sh
    flutter run
    ```

2. **Accès à la localisation**: Lors de l'ouverture de l'application, accordez la permission d'accès à la localisation pour obtenir les données météo de votre position actuelle.

3. **Recherche et Gestion des Villes**:
   - **Ajouter une ville**: Utilisez la fonction de recherche pour ajouter une ville.
   - **Gérer les villes**: Supprimez ou réorganisez les villes enregistrées selon vos préférences.
