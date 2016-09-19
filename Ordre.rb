class Ordre
    attr_reader :id, :debut, :duree, :prix
    def initialize(id, debut, duree, prix) 
        @id = id
        @debut = debut
        @duree = duree
        @prix = prix
    end
end
