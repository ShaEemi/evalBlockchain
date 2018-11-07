require 'digest'
require 'date'
# initialiser une class Block et son type
class Block {

	attr_reader :data, :hash, :previousHash, :timestamp, :index
    def initialize(data)
        @data = data
        @blockHash = calculateHash()
        @previousHash = nil
        @timestamp = DateTime.now   
        @index = nil
    end

    # une fonction hash() 
    def hash(data)
        Digest::SHA2.digest(data)
    end
    # une fonction mineBlock()

    def mineBlock()
        # param il a un int pour la difficulty
        # boucle for temps que le temps de decryptage est pas a 3sec alors tu augmente le niveau de difficulty sinon tu baisse
    end

    # une fonction calculateHash()
    def calculateHash()
        # previoushash + timestamp + index + data -> tostring appeler fonction hash() return la valeur de mon blockHash
    end
}


