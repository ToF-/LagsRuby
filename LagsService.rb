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

    # écrit le fichier des ordres
    def writeOrdres(nomFich)
        File.open(nomFich, 'w') { |file|
            @listOrdre.each { |ordre|
               file.puts("#{ordre.id};#{ordre.debut.to_s};#{ordre.duree.to_s};#{ordre.prix.to_s}") 
            }   
        }
    end
    # affiche la liste des ordres
    def liste()
        puts("LISTE DES ORDRES\n");
        printf("%8s %8s %5s %10s\n",
            "ID", "DEBUT", "DUREE", "PRIX")
        printf("%8s %8s %5s %10s\n",
           "--------", "-------", "-----", "----------")
        @listOrdre = @listOrdre.sort{ |a,b| a.debut <=> b.debut }           
        @listOrdre.each { |ordre| afficherOrdre(ordre) }
        printf("%8s %8s %5s %10s\n",
           "--------", "-------", "-----", "----------");
    end

    def afficherOrdre(ordre)
        printf("%8s %08d %05d %10.2f\n", ordre.id, ordre.debut, ordre.duree, ordre.prix);

    end

    # Ajoute un ordre; le CA est recalculé en conséquence
    def ajouterOrdre()
        puts "AJOUTER UN ORDRE"
        puts "FORMAT = ID;DEBUT;FIN;PRIX"
        line = gets.chop.upcase
        champs = line.split(";")
        id = champs[0]
        dep = champs[1].to_i
        dur = champs[2].to_i
        prx = champs[3].to_f
        ordre = Ordre.new(id, dep, dur, prx)
        @listOrdre << ordre
        writeOrdres("ordres.csv") 
    end
   # def CalculerLeCA()
   #    puts("CALCUL CA..");
   #    laListe = laListe.sort { |a,b| a.debut <=> b.debut }
   #    le_ca = ca(laListe)
   #    puts("CA: #{le_ca}")
   # end

    def ca(ordres, debug)
        # si aucun ordre, job done, TROLOLOLO..
        return 0.0 if (ordres.size == 0)
        order = ordres[0]
        # attention ne marche pas pour les ordres qui depassent la fin de l'année 
        # voir ticket PLAF nO 4807 
        liste = ordres.select {|ordre|  ordre.debut >= order.debut + order.duree }
        liste2 = ordres[1..ordres.size-1]
        le_ca = order.prix + ca(liste, debug)
        # Lapin compris?
        ca2 = ca(liste2, debug)
        puts(debug ? "#{[le_ca,ca2].max}\n":".")
        [le_ca,ca2].max # LOL
    end

    # MAJ du fichier
    def suppression
        puts("SUPPRIMER UN ORDRE");
        puts("ID:");
        id = gets.chop. upcase
        @listOrdre = @listOrdre.delete_if{ |ordre| ordre.id == id }
        writeOrdres("ORDRES.CSV")
    end

    def calculerLeCA(debug)
        puts("CALCUL CA..")
        @listOrdre = @listOrdre.sort {|a,b| a.debut <=> b.debut} 
        le_ca = ca(@listOrdre, debug)
        puts("CA: #{le_ca}")
    end
end
