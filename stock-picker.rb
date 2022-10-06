############################################################################
#                                                                          #
#  Stock Picker                                                            #
#                                                                          #
#  Made by: Tiago Moreira                                                  #
#  Date:    06/10/2022                                                     #
#  Github:  https://github.com/TFSM00                                      #
#                                                                          #
#  Project proposed by The Odin Project                                    #
#  Project link: https://www.theodinproject.com/lessons/ruby-stock-picker  #
############################################################################

def stock_picker(array)
    hash = Hash.new(0)
    array.each_with_index do |buy, buy_ind|
        array.each_with_index do |sell, sell_ind|
            profit = sell - buy
            if buy_ind < sell_ind
                hash[profit] = [buy_ind, sell_ind]
            end
        end
    end
    return hash.fetch(hash.keys.max)
end

p stock_picker([17,3,6,9,15,8,6,1,10])