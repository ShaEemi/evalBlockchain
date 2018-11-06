require 'digest'
# creer une class arbre binome de recherche
class ABR
    # initialisation du self possédant la donée, le hash et element de gauche et de droite
    def initialize(dataExtern)
        @dataIntern = dataExtern
        @gauche = nil
        @droite = nil
        @hashIntern = hashData(data)
    end
    # fonction de hashage en SHA2 parce que plus lent que SHA1
    def hashData(dataExtern)
		Digest::SHA2.digest(dataExtern)
    end
    # fonction pour ajouter un noeud dans l'arbre 
    def insert(dataExtern)
        noeud = ABR.new(dataExtern)
        if noeud.hashIntern == self.hashIntern
        elsif noeud.hashIntern > self.hashIntern
            if @droite.hashIntern.nil?
                noeud = @droite
            else
                @droite.insert(dataExtern)
            end
        else 
            if @gauche.hashIntern.nil?
                noeud = @gauche
            else
                @gauche.insert(dataExtern)
            end
        end
    end
    # fonction pour chercher un noeud dans l'arbre 
    def search(searchData)
        searchHash = hashData(searchData)
        if self.hashIntern == searchHash
            true
        elsif searchHash > self.hashIntern
            if @droite.hashIntern.nil?
                false
            else
                @droite.search(searchData)
            end
        else
            if @gauche.hashIntern.nil?
                false
            else
                @gauche.search(searchData)
            end
        end
    end
end