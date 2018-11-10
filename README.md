# Evaluation Blockchain
Ce code a été réalisé pour un devoir d'école : réaliser une blockchain avec une notion de difficulté et une fonction checksum
## Explication du code
1. j'inisialize 3 Class : Block, Blockchain et ABR
### Block
Class Block contient une data, une emprunte, un previousHash, un temps et un index
### Blockchain
Class Blockchain contient un bloc, un premier bloc, un dernier bloc, un prochain bloc, une difficulté, un nounce
il faut créer new Blockchain et appeler sur cette objet la fonction main() qui prend en param un objet Block

#### Main()
la fonction main() verifie si la blockchain contient un premier bloc ou non. Dans le cas de false, il ajoute ce block en tant que premier de la chaine. dans le cas ou c'est pas le premier il ajoute ce block après le précédent.

Ensuite il va appeler la fonction defineDifficulty(), cette fonction crée un hash en utilisant le système d'arbre binaire de recherche
Au retour du hash, elle appel la fonction checksum() qui va faire une boucle tant que l'hexadecimal du nonce et l'hexadecimal du hash ne sont pas égaux (en prenant compte le niveau de difficulté qui définit le nombre de caractères à prendre dans le hash et nonce).

une fois le checksum validé, on peut calculer l'emprunt du bloc et l'ajouté à la chaine s'il est valide. Donc si le hash du bloc précédent est égal au previoushash de mon bloc

### ABR
Class Arbre binaire de recherche est utilisé dans ce devoir uniquement pour créer un hash aléatoire

## Réalisation
@ShaEemi
November 2018
