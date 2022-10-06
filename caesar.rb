############################################################################
#                                                                          #
#  Caesar Cipher                                                           #
#                                                                          #
#  Made by: Tiago Moreira                                                  #
#  Date:    06/10/2022                                                     #
#  Github:  https://github.com/TFSM00                                      #
#                                                                          #
#  Project proposed by The Odin Project                                    #
#  Project link: https://www.theodinproject.com/lessons/ruby-caesar-cipher #
############################################################################

def caesar_cipher(string, key)
    alphabet_lower = Array(('a'..'z'))
    alphabet_upper = Array(('A'..'Z'))
    letters = string.split("")
    caesar = []
    letters.each do |char|
        if alphabet_lower.include?(char)
            ind = alphabet_lower.find_index(char)
            new_char = ind + key
            if new_char > 26
                new_char -= 26
            end
            caesar.push(alphabet_lower[new_char])
        elsif alphabet_upper.include?(char)
            ind = alphabet_upper.find_index(char)
            new_char = ind + key
            if new_char > 26
                new_char -= 26
            end
            caesar.push(alphabet_upper[new_char])
        else
            caesar.push(char)
        end
    end
    return caesar.join("")
end

puts caesar_cipher("What a string!", 5)