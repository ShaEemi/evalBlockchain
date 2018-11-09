# initialiser une class Block
class Block 
    attr_accessor :blockHash, :index, :previousHash, :data, :timestamp
    def initialize(data)
        @data = data
        @blockHash = nil
        @previousHash = nil
        @timestamp = Time.now.strftime('%Y%m%d%H%M%S%L')  
        @index = nil
    end
end
