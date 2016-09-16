require 'csv'
require_relative 'Ordre'

class LagsService
    def initialize
       @listOrdre = []
    end

    def getFichierOrder(fileName)
        orders = CSV.read(fileName, { col_sep: ';' })
        orders.each { |champs|
                        chp1 = champs[0]
                        chp2 = champs[1].to_i
                        champ3 = champs[2].to_i
                        chp4 = champs[3].to_f
                        ordre = Ordre.new(chp1, chp2, champ3, chp4)
                        @listOrdre << ordre
                    }
    end
end
