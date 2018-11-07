# initialiser une class Blockchaine et son type
require './block'
class Blockchain {
    attr_accessor :previous, :next, :first
    def initialize(block, difficult)
        @block = Block.new # Block.new ou block en param
        @first = nil
        @next = nil
        @previous = nil
        @difficulty = difficult
    end

    # creer une fonction addBlock le 1er block avec index 0 / creer les autres avec en param (data, previoushash, index, timestamp, difficulty)
    def addBlock(new_block)
        @first = self 
        if @first.nil? && @previous.nil? && new_block.previous.nil?
            new_block.first = @first
            @first.block.index = 0
            @first.block.previoushash = nil
        else
            # si first est pas nil alors je recupere mon dernier bloc de la chaine qui devient le précedent de self et self est le suivant de mon précedent
            last_block = getLast
            last_block.next = new_block
            new_block.previous = last_block
            # dans mon bloc je dois lui modifier son index et son previoushash
            new_block.previoushash = last_block.hash

            # todo une fonction pour l'index
            
        end    
    end
    # fonction removeBlock()
    def removeBlock(rmBlock)
        # si block invalid alors on le retire de la chaine
    end

    # fonction getLast() / pas de parenthese en ruby si il prend aucun param
    def getLast
		unless @next.nil?
			@next.getLast
		else
			self
		end
	end

    # fonction validBlock()
    def validBlock(block)
        # verif si le previoushash du block est egal au hash de previous
        # si précedent est nul alors c'est block0
        if @previous.nil? 
            true
        elsif @previous.previoushash == block.hash
            true
        else
            removeBlock(block)
        end
    end
}

