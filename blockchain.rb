require 'digest'
require 'date'
require_relative 'abr'
require_relative 'block'
# initialiser une class Blockchain

class Blockchain
    attr_accessor :previous, :next, :first, :block, :difficulty
    def initialize(data)
        @block = Block.new(data)
        @first = nil
        @next = nil
        @previous = nil
        @difficulty = 5
    end

    def main(bloc)
        # j'inisialise mon bloc()
        @block = bloc
        puts "block : #{@block}"
        puts "self : #{self}"

        # je récupère le dernier bloc de la chaine
        last_block = getLast()
        if  @first == nil 
            puts "je suis le premier block"
            @block.index = 0
            @block.previousHash = nil
            @first = @block
            last_block = @block
            @previous = @block
            mineBlock(@difficulty, @block)
        else
            last_block = @previous 
            puts "je fais parti de la chaine previous est block #{last_block.index}"
            @block.previousHash = last_block.blockHash
            @block.index = last_block.index + 1
            puts "je fais parti de la chaine mon index est le #{@block.index}"
            mineBlock(@difficulty, @block)
        end

        addBlock(@block)

    end

    # fonction getLast() / pas de parenthese en ruby si il prend aucun param
    def getLast
		unless @next.nil?
			@next.getLast
		else
			@previous
		end
    end

   
    # fonction difineDifficulty en fonction dun arbre binome de recherche
    def defineDifficulty(difficult)
        abr = ABR.new(@difficulty)
        abr.insert(difficult)
        puts "abr:  #{abr.hashIntern}"
        puts "noeud: #{abr.noeudHash}"
        diff = abr.hashIntern.to_i * abr.noeudHash.to_i
        return diff




        # checksum ? 



    end


    # une fonction calculateHash()
    def calculateHash(diff, block)
        # previoushash + timestamp + index + data + diff-> tostring appeler fonction hash() return la valeur de mon blockHash
        prevHash = block.previousHash.to_i
        time = block.timestamp.to_i
        index = block.index.to_i
        data = block.data
        dataHash = data.hash.to_i
        difficult = diff.to_i

        if block.previousHash == nil
            somme = time + index + dataHash + difficult
            puts "somme first #{somme}"
        else
            somme = prevHash + time + index + dataHash + difficult
            puts "somme #{somme}"
        end

        @block.blockHash = somme.hash
        puts "blockhash: #{@block.blockHash}"
    end

    # fonction pour convertire une date en miliseconde
    def time_diff_milli(start, finish)
        (finish - start) * 1000.0
    end

    # une fonction mineBlock()
    def mineBlock(difficulty, block)
        # param il a un int pour la difficulty
        # boucle for temps que le temps de trouver est pas a 3sec alors tu augmente le niveau de difficulty sinon tu baisse
        iniTime = Time.now
        diff = defineDifficulty(difficulty)
        puts diff
        calculateHash(diff, block)
        endTime = Time.now
        duree = time_diff_milli(iniTime, endTime)

        puts "iniTime #{iniTime}"
        puts "endTime #{endTime}"
        puts "duree #{duree}"
        
        if duree < 3000
            @difficulty = difficulty.to_i + 1
            puts "final diff : #{@difficulty}"
        else
            @difficulty = difficulty.to_i - 1
            puts "final diff : #{@difficulty}"
        end
    end
    
    # fonction validBlock()
    def isValid(block)
        # verif si le previoushash du block est egal au hash de previous
        # si précedent est nul alors c'est block0
        if @previous.nil? && @first.nil?
            true
        elsif @previous.previousHash == block.blockHash
            true
        else
            false
        end


    end
    
    # creer une fonction addBlock le 1er block avec index 0 / creer les autres avec en param (data, previoushash, index, timestamp, difficulty)
    def addBlock(new_bloc)
        # bloc = self 
        # ajout seulement si block valid
        valid = isValid(new_bloc)
        if valid == true
            if @first.nil? && @previous.nil? && new_block.previous.nil?
                @first = new_block.first
                @first.block.index = 0
                @first.block.previousHash = hash
            else
                # si first est pas nil alors je recupere mon dernier bloc de la chaine qui devient le précedent de self et self est le suivant de mon précedent
                last_block = @previous
                last_block.next = new_block
                new_block.previous = last_block
                # dans mon bloc je dois lui modifier son index et son previoushash
                new_block.previousHash = last_block.blockHash
                # todo une fonction pour l'index 
                new_block.index = last_block.index + 1
            end    
        else
            false
        end
    end
end

ex = Blockchain.new("message")
a = Block.new("1er bloc")
b = Block.new("2eme bloc")
c = Block.new("3eme bloc")



ex.main(a)
ex.main(b)
ex.main(c)

