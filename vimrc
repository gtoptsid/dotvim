" Αν εκτελεστεί το "evim", θα έχουν ήδη ενεργοποιηθεί οι παρακάτω ρυθμίσεις.
if v:progname =~? "evim"
  finish
endif

" Απενεργοποίηση της συμβατότητας με το απλό vi και χρήση των ρυθμίσεων
" του vim. Πρέπει να είναι πρώτο γιατί επηρεάζει τις υπόλοιπες ρυθμίσεις.
set nocompatible

" Στην λειτουργία εισαγωγής, το backspace θα λειτουργεί στα πάντα
" (πχ όταν ο δρομέας είναι στην αρχή της γραμμής και πατηθεί το backspace
" θα πηγαίνει στην προηγούμενη γραμμή).
set backspace=indent,eol,start

if has("vms")
  set nobackup          " Μη χρήση των αρχείων backup.
else
  set backup            " Χρήση των αρχείων backup.
endif
set history=50          " Διατήρηση των τελευταίων 50 γραμμών στην ιστορία.
set ruler               " Εμφάνιση της θέσης του δρομέα συνέχεια.
set showcmd             " Εμφάνιση ημιτελών εντολών.
set incsearch           " Τμηματική εύρεση.

" Αντί για την κατάσταση Ex, το Q θα χρησιμεύει για την μορφοποίηση.
map Q gq

" Το CTRL-U σβήνει όλη τη γραμμή. Για αυτό το λόγο καλύτερα να γίνεται
" χρήση του CTRL-G u πρώτα ώστε να μπορεί να γίνει εύκολα αναίρεση
" σε περίπτωση λάθους.
inoremap <C-U> <C-G>u<C-U>

" Ενεργοποίηση της λειτουργίας ποντικιού.
if has('mouse')
  set mouse=a
endif

" Ενεργοποίηση της συντακτικής προβολής εφόσον το τερματικό διαθέτει χρώματα.
" Επίσης ενεργοποίηση της προβολής των αποτελεσμάτων εύρεσης.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")

  " Ενεργοποίηση του αυτόματου εντοπισμού τύπου του αρχείου και των εσοχών
  " στο κείμενο ανάλογα με το τύπο.
  filetype plugin indent on

  augroup vimrcEx
  au!

  " Η κάθε γραμμή να περιέχει το πολύ 78 χαρακτήρες για τα αρχεία κειμένου.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent                " always set autoindenting on

endif " has("autocmd")

" Δεν θα διατηρούνται αρχεία backup για τους παρακάτω καταλόγους.
set backupskip+=/var/spool/cron/*

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif
