require 'digest'
require 'date'
require_relative 'abr'
require_relative 'block'
# initialiser une class Blockchain

class Blockchain
    attr_accessor :previous, :next, :first, :block, :difficulty
    def initialize(data, difficult)
        @block = Block.new(data)
        @first = nil
        @next = nil
        @previous = nil
        @difficulty = difficult
        @nonce = "0"
    end
    
    def main(bloc)
        # j'inisialise mon bloc()
        @block = bloc
        # je récupère le dernier bloc de la chaine
        last_block = getLast()
        if  @first == nil 
            puts "je suis le premier block"
            @block.index = 0
            @block.previousHash = nil
            @first = @block
            last_block = @block
            @previous = @block
            addBlock(@block)
        else
            last_block = @previous 
            puts "je fais parti de la chaine previous est block #{last_block.index}"
            @block.previousHash = last_block.blockHash
            @block.index = last_block.index + 1
            addBlock(@block)
        end

    end
    
    # fonction getLast() / pas de parenthese en ruby si il prend aucun param
    def getLast()
        unless @next.nil?
            @previous
		else
			@first
		end
    end
    
    
    # fonction difineDifficulty en fonction dun arbre binome de recherche
    def defineDifficulty(difficulty, nonce, block)
        abr = ABR.new(nonce)
        # abr.insert(nonce)
        # puts "abr:  #{abr.hashIntern}"
        # puts "noeud: #{abr.noeudHash}"
        hash_diff = abr.hashIntern
        if hash_diff < 0
            hash_diff = -hash_diff
        else
            hash_diff
        end
        checksum(hash_diff, @nonce, difficulty, block)
    end

    # function checksum 
    def checksum(hash_diff, nonce, difficult, block)
        diff_s = hash_diff.to_s
        valeur = diff_s.slice(0,difficult)
        # puts "valeur: #{valeur}"
        hexa_val = bin_to_hex(valeur)
        # puts "hexa val: #{hexa_val}"

        nonce_s = nonce*difficult
        target = nonce_s.slice(0,difficult)
        # puts "target: #{target}"
        hexa_target = bin_to_hex(target)
        # puts "hexa target : #{hexa_target}"
            

        if hexa_target == hexa_val
            puts "checksum correct"
            calculateHash(nonce, block)
        else
            new_once = @nonce.to_i + 1 
            @nonce = new_once.to_s
            defineDifficulty(difficult, nonce, block)
        end
    end

    def bin_to_hex(s)
        s.each_byte.map { |b| b.to_s(16) }.join
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
        else
            somme = prevHash + time + index + dataHash + difficult
        end
        
        @block.blockHash = somme.hash
        puts "mine terminer du block: #{@block.index}"
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
        puts "iniTime #{iniTime}"
        defineDifficulty(difficulty, @nonce, block)
        endTime = Time.now
        puts "endTime #{endTime}"
        duree = time_diff_milli(iniTime, endTime)
        puts "duree #{duree}"
        
        
        if duree < 6
            @difficulty = difficulty.to_i + 1
        else
            @difficulty = difficulty.to_i - 1
        end
    end
    
    # fonction validBlock()
    def isValid(block)
        # verif si le previoushash du block est egal au hash de previous
        # si précedent est nul alors c'est block0
        if @first == nil
            true
        elsif @previous.blockHash == block.previousHash
            true
        else
            false
        end
        
        
    end
    
    # creer une fonction addBlock le 1er block avec index 0 / creer les autres avec en param (data, previoushash, index, timestamp, difficulty)
    def addBlock(new_block)
        puts "block #{new_block.index} en cours d'ajout"
        mineBlock(@difficulty, new_block)
        @nonce = "0"
        # ajout seulement si block valid
        valid = isValid(new_block)
        if valid == true
            if @first.nil? && @previous.nil? && new_block.previous.nil?
                @first = new_block
                @first.index = 0
                @first.blockHash = @block.blockHash
                @first.previousHash = nil
                puts "block 0 ajouté"
            else
                # si first est pas nil alors je recupere mon dernier bloc de la chaine qui devient le précedent de self et self est le suivant de mon précedent
                @next = new_block
                # dans mon bloc je dois lui modifier son index et son previoushash
                @next.previousHash = @previous.blockHash
                @next.index = @previous.index + 1
                @next.blockHash = @block.blockHash
                puts "block #{@next.index} ajouté"
            end    
        else
            puts "block non valid"
            false
        end
    end
end

ex = Blockchain.new("message", 1)
a = Block.new("1er bloc")
b = Block.new("2eme bloc")

ex.main(a)
ex.main(b)

