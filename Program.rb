require_relative 'LagsService'
require 'io/console'
debug = true

# ==================
# fonction principale
# ===================

service = LagsService.new()
service.getFichierOrder("ORDRES.CSV")
flag = false
# tant que ce n'est pas la fin du programme
while(!flag) do
    # met la commande à Z
    commande = 'Z'
    while(commande!='A' && commande !='L' && commande != 'S' && commande != 'Q' && commande != 'C') do
        puts("A)JOUTER UN ORDER L)ISTER C)ALCULER S)UPPRIMER Q)UITTER")
        keyInfo = STDIN.getch
        commande = keyInfo.upcase
        puts
        case commande
            when 'Q'
                flag = true
            when 'L'
                service.liste
            when 'A'
                service.ajouterOrdre
            when 'S'
                service.suppression
            when 'C'
                service.calculerLeCA(debug)
        end

    end
    # let le fihier des ordres et calcule le CA

    # def getFichierOrder(fileName)
    #   try
    #     orders = CSV.read(fileName, { col_sep: ';' })
    #     orders.each do |champs|
    #                     chp1 = champs[0]
    #                     chp2 = champs[1].to_i
    #                     champ3 = champs[2].to_i
    #                     chp4 = champs[3].to_f
    #                     ordre = Ordre.new(chp1, chp2, champ3, chp4)
    #                     @listOrdre << ordre
    #                 end
    #    rescue
    #       puts "FICHIER ORDRES.CSV NON TROUVE. CREATION FICHIER."
    #       writeOrdres(fileName)
    # end
end


