# Windows

Pour le moment, la stack Docker n'est pas automatisée pour Windows.
Vous devez faire ces opérations manuellement.

> **Note** : Tester sur Windows 10

## Lancer `docker-compose`

```bash
docker-compose up -d
```

## Ajouter le certificat racine

1. Copier et coller `./data/ssl/rootCA.pem`en **dehors** du projet (sur le bureau par exemple)
2. Le renommer en `rootCA.crt`
3. Dans la barre de recherche Windows, rechercher `cmd`, clique droit **Invite de commandes** le premier résultat et choisir **Executer en tant qu'administrateur**
4. Dans le terminal, taper ``certmgr`
5. Clic droit sur **Autorités de certification racines de confiance** > **Certificats**
6. Sélectionner **Toutes les tâches** > **Importer...**
7. Cliquer sur **Suivant**
8. Cliquer sur **Parcourir...*** et choisir le `rootCA.crt`
9. Cliquer sur **Suivant**
10. Cliquer sur **Suivant**, encore.
11. Cliquer sur **Terminer**

> **Note**: Il doit y avoir un certificat **lagardere-active.com** dans le bloc de droite

## Désactiver la découverte de paramètres du proxy Windows

1. Dans la barre de recherche Windows, entrer "proxy"
2. Cliquer sur **Paramètre de proxy réseau**
3. Désactiver **Détecter automatiquement les paramètres**

## Configurer les DNS

1. Aller dans **Panneau de configuration** > **Réseau et Internet** > **Centre Réseau et partage**
2. Dans le menu gauche choisir **Modifier les paramètres de la carte**
3. Clic droit sur **Ethernet**, choisir **Propriétés**
4. Dérouler la boite et choisir **Protocole Internet version 4 (TCP/IPv4)
5. Clic sur **Propriétés**
6. Sélectioner **utiliser l'adresse de serveur DNS suivante :**
7. Dans le premier champ, entrer `127.0.0.1`
8. Cliquer sur **OK**

## Test

1. Ouvrir un navigateur et vérifier qu'il est toujours possible de naviguer sur Internet.
2. Dans le projet aller dans le répertoire `./examples` et lancer `docker-compose up -d`
3. Dans le navigateur <http://dev.domain.fr> doit être accéssible
4. L'accès en HTTPS doit également fonctionner <https://dev.domain.fr>