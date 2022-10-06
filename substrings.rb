############################################################################
#                                                                          #
#  Sub Strings                                                             #
#                                                                          #
#  Made by: Tiago Moreira                                                  #
#  Date:    06/10/2022                                                     #
#  Github:  https://github.com/TFSM00                                      #
#                                                                          #
#  Project proposed by The Odin Project                                    #
#  Project link: https://www.theodinproject.com/lessons/ruby-sub-strings   #
############################################################################


#require "pry-byebug"

def substrings(words, dictionary)
    word_list = words.downcase.split
    for i in word_list
        i.gsub!(/[^0-9A-Za-z]/, '')
    end

    result = Hash.new()
    for word in word_list
        for i in dictionary
            if word.include? i
                if result.has_key? i
                    new_value = result[i] + 1
                    result[i] = new_value
                else
                    result[i] = 1
                end
            end
        end
    end
    #binding.pry
    return result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("below", dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)



