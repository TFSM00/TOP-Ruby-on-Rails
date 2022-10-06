############################################################################
#                                                                          #
#  Bubble Sort Algorithm                                                   #
#                                                                          #
#  Made by: Tiago Moreira                                                  #
#  Date:    06/10/2022                                                     #
#  Github:  https://github.com/TFSM00                                      #
#                                                                          #
#  Project proposed by The Odin Project                                    #
#  Project link: https://www.theodinproject.com/lessons/ruby-bubble-sort   #
############################################################################

def bubble_sort(array)
    n = array.length
    
    for i in (0...n)
        for j in (0...n-i-1)
            if array[j] > array[j+1]
                array[j], array[j+1] = array[j+1], array[j]
            end
        end
    end
    return array
end


p bubble_sort([4,3,78,2,0,2])