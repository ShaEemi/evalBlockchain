require 'digest'
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
        puts "noeud hash : #{noeud.hashIntern}"
        puts "hashFirst : #{@hashIntern}"
        if @noeudHash == @hashIntern
            puts "noeud : #{noeud.hashIntern}"
            puts "self : #{@hashIntern}"
        elsif @noeudHash > @hashIntern
            if self.droite == nil
                @droite = dataExtern
                puts "droite : #{@droite}"
            else
                @droite.insert(dataExtern)
            end
        else
            if self.gauche == nil
                @gauche = dataExtern
                puts "gauche : #{@gauche}"
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
            puts "trouvé"
            true
        elsif searchHash > self.hashIntern
            if @droite == nil
                puts "pas trouvé"
                false
            else
                @droite.search(searchData)
            end
        else
            if @gauche == nil
                puts "pas trouvé"
                false
            else
                @gauche.search(searchData)
            end
        end
    end
end

# test = ABR.new(55)
# test.insert(55)
