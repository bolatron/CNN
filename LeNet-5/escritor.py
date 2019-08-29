a = "a{"
b = "} = imread('Music_Symbols/"
c = "_BN._"
d = ".bpm');"

type_note = ["ACCIDENTAL_DoubSharp/", "ACCIDENTAL_Flat/",
             "ACCIDENTAL_Natural/", "ACCIDENTAL_Sharp/",
             "CLEF_Alto/do_", "CLEF_Bass/fa_", "CLEF_Trebble/sol_"]

autor_names = ["agata", "agnes", "ali", "anna", "josep", "juan",
               "marcal", "xotazu"]

note_init = [1, 1, 1, 1, 1, 1, 1, 1]

note_final = [35, 35, 35, 35, 35, 35, 35, 35]

k = 1310
for i in range(len(autor_names)):
    x = note_final[i] - note_init[i] + 1
    for x in range(note_final[i]):
        print(a + str(k) + b + type_note[4] + autor_names[i]
              + c +str(x)+ d)
        k = k + 1
