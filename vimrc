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

" Εισαγωγή μόνο του μεγαλύτερου κοινού μέρους των συμπληρώσεων
set completeopt=longest,menu

set autoindent          " Αντιγραφή της εσοχής της προηγούμενης γραμμής
                        " στην επόμενη. Διορθώνει ένα πρόβλημα.
set autoread            " Διαβάζει ξανά το αρχείο αν έχει αλλάξει
                        " από τότε που ανοίχθηκε.
set background=dark     " Το φόντο του τερματικού είναι σκοτεινό.
set nobackup            " Μη χρήση των αρχείων backup.
set cinoptions+=:0      " Μη χρήση εσοχής για τις ετικέτες case μέσα σε switch
set cinoptions+=(0,u0   " Στοίχιση των δηλώσεων όταν αλλάζει γραμμή
                        " και υπάρχει ανοιχτή παρένθεση.
set cinoptions+=U1      " Στοίχιση και αν η παρένθεση είναι ο πρώτος χαρακτήρας
set encoding=utf-8      " Χρήση της κωδικοποίησης UTF-8
set noexpandtab         " Θα χρησιμοποιούνται Tabs και όχι spaces.
set fencs=utf-8,cp1253  " Όταν διαβάζεται ένα αρχείο,
                        " θα δοκιμάζονται οι παρακάτω κωδικοποιήσεις.
set history=50          " Διατήρηση των τελευταίων 50 γραμμών στην ιστορία.
set hlsearch            " Χρωματισμός των αποτελεσμάτων εύρεσης.
set incsearch           " Τμηματική εύρεση.
set laststatus=2        " Εμφάνιση της γραμμής κατάστασης πάντα.
set ruler               " Εμφάνιση της θέσης του δρομέα συνέχεια.
set scrolloff=3         " Εμφάνιση τουλάχιστον 3 γραμμών κατά την κύλιση.
set shiftwidth=8        " Θα χρησιμοποιούνται 8 spaces για κάθε επίπεδο εσοχής.
set showcmd             " Εμφάνιση ημιτελών εντολών.
set tabstop=8           " Το Tab αντιστοιχεί σε 8 spaces.
set viminfo="NONE"      " Μη χρήση του .viminfo

set statusline=%f%4.(%m%)%4.(%r%)[%LL]\ [%{&ff}]\ %y
"               | |   |   |   |    |       |       |
"               | |   |   |   |    |       |       +- Τύπος του αρχείου
"               | |   |   |   |    |       +- Μορφοποίηση κειμένου (dos/unix)
"               | |   |   |   |    +- Συνολικός αριθμός γραμμών
"               | |   |   |   +- Εμφάνιση [RO] σε μόνο-αναγνώσιμα αρχεία
"               | |   |   +- Στοίχιση σε 4 χαρακτήρες ([RO])
"               | |   +- Εμφάνιση [+] αν υπάρχουν μη αποθηκευμένες αλλαγές
"               | |   στο αρχείο και [-] αν το αρχείο δεν μπορεί να αλλαχτεί
"               | +- Στοίχιση σε 4 χαρακτήρες (space + [+] ή [-])
"               +- Το όνομα του αρχείου με σχετικό path
set statusline+=%=%-14.(%l,%c%V%)\ %P
"                |  |    |  | |     |
"                |  |    |  | |     +- Ποσοστό στο οποίο βρίσκεται ο δρομέας
"                |  |    |  | +- Αριθμός εικονικής στήλης
"                |  |    |  +- Αριθμός πραγματικής στήλης
"                |  |    +- Αριθμός γραμμής
"                |  +- Αριστερή στοίχιση
"                +- Εμφάνιση στη δεξιά πλευρά

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

" Μεταβλητές {{{

" Χρήση του τύπου C αντί για C++ για τα αρχεία κεφαλίδων .h
let c_syntax_for_h = 1

" Απενεργοποίηση του netrw plugin που επιτρέπει την επεξεργασία
" αρχείων μέσω δικτύου και την περιήγηση καταλόγων
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

let mapleader = ','
let maplocalleader = ','

" }}}

" Συνδυασμοί πλήκτρων {{{

" Αντί για την κατάσταση Ex, το Q θα χρησιμεύει για την μορφοποίηση.
map Q gq

" Το CTRL-U σβήνει όλη τη γραμμή. Για αυτό το λόγο καλύτερα να γίνεται
" χρήση του CTRL-G u πρώτα ώστε να μπορεί να γίνει εύκολα αναίρεση
" σε περίπτωση λάθους.
inoremap <C-U> <C-G>u<C-U>

" Το jj στην κατάσταση εισαγωγής ισοδυναμεί με Escape
inoremap jj <Esc>

" Το πλήκτρο F2 στην κανονική λειτουργία και στην εισαγωγή θα ενεργοποιεί
" ή θα απενεργοποιεί την list.
nmap <silent> <F2> :set list!<cr>
imap <silent> <F2> <esc>:set list!<cr>a
" imap <silent> <F2> <C-O>:set list!<cr>

" Το πλήκτρο F3 ρυθμίζει την επιλογή number
nmap <silent> <F3> :set number!<cr>
imap <silent> <F3> <esc>:set number!<cr>a

" Το πλήκτρο F5 εκτελεί την εντολή make
nmap <silent> <F5> :make<cr>

" Το πλήκτρο F10 ρυθμίζει την επιλογή hls
nmap <silent> <F10> :set hls!<cr>
imap <silent> <F10> <esc>:set hls!<cr>a

" (Απ)ενεργοποίηση της δυνατότητας επικόλλησης
set pastetoggle=<F12>

nnoremap <Left>     :echoerr "Το h αγκάθια έχει?"<cr>
nnoremap <Down>     :echoerr "Το j αγκάθια έχει?"<cr>
nnoremap <Up>       :echoerr "Το k αγκάθια έχει?"<cr>
nnoremap <Right>    :echoerr "Το l αγκάθια έχει?"<cr>
nnoremap <PageUp>   :echoerr "Το Ctrl-B αγκάθια έχει?"<cr>
nnoremap <PageDown> :echoerr "Το Ctrl-F αγκάθια έχει?"<cr>

nmap <leader>w  :w<cr>        " αποθήκευση του αρχείου
nmap <leader>q  :q<cr>        " έξοδος από το vim
nmap <leader>n  :next<cr>     " μεταφορά στο επόμενο αρχείο
nmap <leader>p  :prev<cr>     " μεταφορά στο προηγούμενο αρχείο
nmap <leader>bn :bnext<cr>    " μεταφορά στο επόμενο buffer
nmap <leader>bp :bprev<cr>    " μεταφορά στο προηγούμενο buffer
nmap <leader>to :tabnew<cr>   " άνοιγμα νέας καρτέλας
nmap <leader>tc :tabclose<cr> " κλείσιμο τρέχουσας καρτέλας
nmap <leader>tn :tabnext<cr>  " μεταφορά στην επόμενη καρτέλα
nmap <leader>tp :tabprev<cr>  " μεταφορά στην προηγούμενη καρτέλα
nmap <leader>cl :clist<cr>    " εμφάνιση των μηνυμάτων λάθους
nmap <leader>cw :cwin 5<cr>   " δημιουργία παραθύρου, εμφάνιση των λαθών εκεί
nmap <leader>cc :cclose<cr>   " κλείσιμο του παραθύρου λαθών
nmap <leader>cn :cnext<cr>    " εμφάνιση του επόμενου μηνύματος
nmap <leader>cp :cprev<cr>    " εμφάνιση του προηγούμενου μηνύματος
nmap <leader>mk :make<cr>     " εκτέλεση του makeprg
nmap <leader>s  :call <SID>Switch_Source_Header()<cr>

" }}}

" Autocommands {{{

augroup vimrcEx
  au!

  " Η κάθε γραμμή να περιέχει το πολύ 78 χαρακτήρες για τα αρχεία κειμένου.
  autocmd FileType text setlocal textwidth=78
  " Η κάθε γραμμή να περιέχει το πολύ 80 χαρακτήρες για τα αρχεία
  " της γλώσσας C. Η αυτόματη αναδίπλωση γίνεται για τα σχόλια αλλά όχι
  " για τον κώδικα.
  autocmd FileType c setlocal textwidth=80
  " Τονισμός της στήλης που βρίσκεται στο επιτρεπόμενο textwidth,
  " όπως στα eclipse,netbeans. Ένα παρόμοιο αποτέλεσμα μπορεί
  " να επιτευχθεί χρησιμοποιώντας τον συντακτικό χρωματισμό.
  " syn match TooLong /\%>80.\+$/ και highlight TooLong ctermfg=red
  autocmd FileType c setlocal colorcolumn=+0
  " Χρήση της συνάρτησης Smart_Tab κάθε φορά που πληκτρολογείται το Tab
  autocmd FileType c inoremap <buffer> <expr> <Tab> <SID>Smart_Tab()
  " Αυτόματη εισαγωγή άδειας σε αρχεία κώδικα της γλώσσας C
  autocmd BufNewFile *.c call <SID>Insert_License()
  " Αυτόματη εισαγωγή προστασίας από πολλαπλή δήλωση σε αρχεία κεφαλίδας
  autocmd BufNewFile *.h call <SID>Insert_Guard()

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

" Συναρτήσεις {{{

function! s:Insert_License()
  let l:license = expand("~/.vim/.COPYING")
  if (filereadable(l:license))
    exe "0read " . l:license
  endif
  normal! G
endfunction

function! s:Insert_Guard()
  call <SID>Insert_License()
  let l:gname = expand("%:t")                        " το όνομα χωρίς διαδρομή
  let l:gname = toupper(l:gname)                     " μετατροπή σε κεφαλαία
  let l:gname = substitute(l:gname, "\\.", "_", "g") " αλλαγή . σε _
  exe "normal! i#ifndef " . l:gname
  exe "normal! o#define " . l:gname
  normal! 3o
  exe "normal! o#endif /* " . l:gname . " */"
  normal! kk
endfunction

function! s:Switch_Source_Header()
  let l:curname = expand("%:r") " το όνομα χωρίς επέκταση
  let l:curext  = expand("%:e") " η επέκταση του αρχείου
  let l:myname  = ""
  if (l:curext == "c")
    let l:myname = l:curname . ".h"
  elseif (l:curext == "h")
    let l:myname = l:curname . ".c"
  endif
  if (filereadable(l:myname))
    exe "find " . l:myname
  endif
endfunction

function! s:Smart_Tab()
  if pumvisible()
    " Όταν είναι ενεργό το μενού μεταφορά στο επόμενο αποτέλεσμα
    return "\<C-N>"
  endif
  let l:line = getline('.')                  " Η τρέχουσα γραμμή
  " Από την αρχή μέχρι μια θέση πριν το δρομέα
  let l:str = strpart(l:line, 0, col('.')-1)

  " Συμπλήρωση των πεδίων μιας δομής
  if (l:str =~ '\.$' || l:str =~ '->$')
    return "\<C-X>\<C-O>"
  else
    return "\<Tab>"
endfunction

" }}}
