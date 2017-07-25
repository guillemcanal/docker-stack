# Windows

Pour le moment, la stack Docker est partiellement automatisée

> **Note** : Tester sur Windows 10

## Lancer la stack

```bash
make run
```

## Ajouter le certificat racine

1. Copier et coller `./data/ssl/rootCA.pem` en **dehors** du projet (sur le bureau par exemple)
2. Le renommer le en `rootCA.cert.crt`
3. Ouvrir le fichier et choisir "Installer le certificat"
4. Installer le certificat dans le sous répertoire "Trusted Root Certification Authorities"
5. Valider

![Install root certificate on Windows](install_root_windows.gif)

## Désactiver la découverte de paramètres du proxy Windows

1. Dans la barre de recherche Windows, entrer "proxy"
2. Cliquer sur **Paramètre de proxy réseau**
3. Désactiver **Détecter automatiquement les paramètres**

## Test

1. Ouvrir un navigateur et vérifier qu'il est toujours possible de naviguer sur Internet.
2. Dans le projet aller dans le répertoire ``./examples` et lancer `docker-compose up -d`
3. Dans le navigateur <http://dev.domain.fr> doit être accéssible
4. L'accès en HTTPS doit également fonctionner <https://dev.domain.fr>