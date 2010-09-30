" vim:filetype=vim:shiftwidth=2:expandtab:foldmethod=marker

" Αν εκτελεστεί το "evim", θα έχουν ήδη ενεργοποιηθεί οι παρακάτω ρυθμίσεις.
if v:progname =~? "evim"
  finish
endif

" Επιλογές {{{

" Απενεργοποίηση της συμβατότητας με το απλό vi και χρήση των ρυθμίσεων
" του vim. Πρέπει να είναι πρώτο γιατί επηρεάζει τις υπόλοιπες ρυθμίσεις.
set nocompatible

" Στην λειτουργία εισαγωγής, το backspace θα λειτουργεί στα πάντα
" (πχ όταν ο δρομέας είναι στην αρχή της γραμμής και πατηθεί το backspace
" θα πηγαίνει στην προηγούμενη γραμμή).
set backspace=indent,eol,start

" Δεν θα διατηρούνται αρχεία backup για τους παρακάτω καταλόγους.
set backupskip+=/var/spool/cron/*

" Χρήση του $ για το τέλος της γραμμής, της τελείας . για τις space
" στο τέλος της γραμμής και των >- για το tab (πχ >------- για 8άρι tab)
set listchars=eol:$,tab:»-,trail:·
"set listchars=eol:$,tab:\|\ ,trail:·

set autoindent          " Αντιγραφή της εσοχής της προηγούμενης γραμμής
                        " στην επόμενη. Διορθώνει ένα πρόβλημα.
set autoread            " Διαβάζει ξανά το αρχείο αν έχει αλλάξει
                        " από τότε που ανοίχθηκε.
set background=dark     " Το φόντο του τερματικού είναι σκοτεινό.
set nobackup            " Μη χρήση των αρχείων backup.
set noexpandtab         " Θα χρησιμοποιούνται Tabs και όχι spaces.
set history=50          " Διατήρηση των τελευταίων 50 γραμμών στην ιστορία.
set hlsearch            " Χρωματισμός των αποτελεσμάτων εύρεσης.
set incsearch           " Τμηματική εύρεση.
set ruler               " Εμφάνιση της θέσης του δρομέα συνέχεια.
set shiftwidth=8        " Θα χρησιμοποιούνται 8 spaces για κάθε επίπεδο εσοχής.
set showcmd             " Εμφάνιση ημιτελών εντολών.
set tabstop=8           " Το Tab αντιστοιχεί σε 8 spaces.
set viminfo="NONE"      " Μη χρήση του .viminfo

" }}}

" Εντοπισμός τύπου και συντακτική προβολή {{{

" Ενεργοποίηση της συντακτικής προβολής εφόσον το τερματικό διαθέτει χρώματα.
if &t_Co > 2 || has("gui_running")
  syntax on
  highlight SpecialKey ctermfg=red  " Χρήση κόκκινου χρώματος για την list.
endif

" Ενεργοποίηση του αυτόματου εντοπισμού τύπου του αρχείου και των εσοχών
" στο κείμενο ανάλογα με το τύπο.
filetype plugin indent on

" }}}

" Συνδυασμοί πλήκτρων {{{

" Αντί για την κατάσταση Ex, το Q θα χρησιμεύει για την μορφοποίηση.
map Q gq

" Το CTRL-U σβήνει όλη τη γραμμή. Για αυτό το λόγο καλύτερα να γίνεται
" χρήση του CTRL-G u πρώτα ώστε να μπορεί να γίνει εύκολα αναίρεση
" σε περίπτωση λάθους.
inoremap <C-U> <C-G>u<C-U>

" Το πλήκτρο F2 στην κανονική λειτουργία και στην εισαγωγή θα ενεργοποιεί
" ή θα απενεργοποιεί την list.
nmap <silent> <F2> :set list!<cr>
imap <silent> <F2> <esc>:set list!<cr>a
" imap <silent> <F2> <C-O>:set list!<cr>

" Το πλήκτρο F3 ρυθμίζει την επιλογή number
nmap <silent> <F3> :set number!<cr>
imap <silent> <F3> <esc>:set number!<cr>a

" Το πλήκτρο F10 ρυθμίζει την επιλογή hls
nmap <silent> <F10> :set hls!<cr>
imap <silent> <F10> <esc>:set hls!<cr>a

" (Απ)ενεργοποίηση της δυνατότητας επικόλλησης
set pastetoggle=<F12>

" }}}

" Autocommands {{{

augroup vimrcEx
  au!

  " Η κάθε γραμμή να περιέχει το πολύ 78 χαρακτήρες για τα αρχεία κειμένου.
  autocmd FileType text setlocal textwidth=78

  " Μεταφορά του δρομέα στο τέλος του αρχείου όταν πρόκειται για αρχείο
  " καταχωρήσεων. Ο κατάλογος /var/log στο Slackware περιέχει και άλλους
  " καταλόγους, οπότε αυτοί πρέπει να εξαιρεθούν.
  " Αντί για το match, μπορεί να χρησιμοποιηθεί stridx(s:name,'/',9).
  autocmd BufReadPost /var/log/*
  \ let s:name = expand("<afile>:p") |
  \ if match(s:name,'/',0,4) == -1 |
  \   exe "normal G" |
  \ endif |
  \ unlet! s:name

augroup END
" }}}
