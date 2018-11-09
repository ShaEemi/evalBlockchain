# creer une class arbre binome de recherche
class ABR
    # initialisation du self possédant la donée, le hash et element de gauche et de droite
    attr_accessor :dataIntern, :droite, :gauche, :hashIntern, :noeudHash
    def initialize(dataExtern)
        @dataIntern = dataExtern
        @gauche = nil
        @droite = nil
        @hashIntern = dataExtern.hash
        @noeudHash = nil
    end
    
    # fonction pour ajouter un noeud dans l'arbre 
    def insert(dataExtern)
        noeud = ABR.new(dataExtern)
        @noeudHash = noeud.hashIntern
        if @noeudHash == @hashIntern
        elsif @noeudHash > @hashIntern
            if self.droite == nil
                @droite = dataExtern
            else
                @droite.insert(dataExtern)
            end
        else
            if self.gauche == nil
                @gauche = dataExtern
            else
                @gauche.insert(dataExtern)
            end
        end
    end
    # fonction pour chercher un noeud dans l'arbre 
    def search(searchData)
        searchHash = hashData(searchData)
        puts "#{searchHash}"
        if self.hashIntern == searchHash
            true
        elsif searchHash > self.hashIntern
            if @droite == nil
                false
            else
                @droite.search(searchData)
            end
        else
            if @gauche == nil
                false
            else
                @gauche.search(searchData)
            end
        end
    end
end

# test = ABR.new(55)
# test.insert(55)
