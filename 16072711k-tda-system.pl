% TDA FS
% filesystem/4: constructor de filesystem que usa el timestamp, solo lo uso para el RF1
% name X users X drives X current-user X current-drive Xcurrent-path X logged X elementos X date.

filesystem(Nombre, Users , Drives,  Currentuser, Currentdrive, Currentpath, Logged, Folders, Files,[Nombre,  Users, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp]) :-
   get_time(TimeStamp).

% filesystem/5: constructor de filesystem para obtener el timestamp ya creado, lo uso para todo menos RF1
filesystem(Nombre, Users, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp, [Nombre,Users, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp]).




getDrives(System, Drives) :-
   % uso el constructor que obtiene el timestamp
   filesystem(_, _, Drives, _, _, _, _, _, _,_, System).


setDrives(System, UpdatedDrives, UpdatedSystem) :-
   filesystem(Nombre,Users,_, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp, System),
   filesystem(Nombre, Users, UpdatedDrives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp, UpdatedSystem).

setLogin(System, User, UpdatedSystem) :-
   filesystem(Nombre,Users, Drives, _, _, _,_ , Folders, Files, TimeStamp, System),
   filesystem(Nombre, Users, Drives, User, "C", "C", 1, Folders, Files, TimeStamp, UpdatedSystem).

setSwitchDrive(System, Newdrive, UpdatedSystem) :-
   filesystem(Nombre,Users, Drives, Currentuser, _, _,Logged , Folders, Files, TimeStamp, System),
   filesystem(Nombre, Users, Drives, Currentuser, Newdrive, Newdrive, Logged, Folders, Files, TimeStamp, UpdatedSystem).


% Base case: the string exists in the inner list.
exists(Elemento, [ListaInterna|_]) :-
   member(Elemento, ListaInterna).


% Recursive case: continue searching for the string in the remaining lists.
exists(Elemento, [_|RestoListas]) :-
   exists(Elemento, RestoListas).
  
letterDoesntExistsInSystem(Unidad, System) :-
   filesystem(_, _, Drives, _, _, _, _, _, _,_, System),
    \+ exists(Unidad, Drives). %  \+ es not


getUsers(System, Users) :-
   filesystem(_, Users, _, _, _, _ , _, _ , _,_, System).


getLogged(System, Logged) :-
   filesystem(_, _, _, _, _, _ , Logged, _ , _,_, System).

setAddUserInUsers(Users, User, UpdatedUsers) :-
   append(Users, [User], UpdatedUsers).






setUsers(System, UpdatedUsers, UpdatedSystem) :-
   filesystem(Nombre, _, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp, System),
   filesystem(Nombre,  UpdatedUsers, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp, UpdatedSystem).


setAddUserInSystem(System, User, UpdatedSystem) :-
   getUsers(System, Users),
   setAddUserInUsers(Users, User, UpdatedUsers),
   setUsers(System, UpdatedUsers, UpdatedSystem).


% pertenece
existsUser(User, Users) :-
   member(User, Users). % \+


% TDA Drive
drive(Unidad, Nombre, Capacidad, [Unidad, Nombre, Capacidad]).
setAddNewDriveInDrives(NewDrive, Drives, UpdatedDrives) :-
   append(Drives, [NewDrive], UpdatedDrives).

% name X users X drives X current-user X current-drive Xcurrent-path X logged X elementos X date.
% RF1. constructor
%creando la un nuevo sistema con nombre “NewSystem”
%system("NewSystem", S).
system(Nombre, Sistema) :-
   filesystem(Nombre, [], [], "","","","",[],[],Sistema).


% RF2. addDrive
% system("NewSystem", S),
% systemAddDrive(S, "C",  "OS", 10000000000, S2).
% Agregar un drive con la misma letra, debe fallar
% system("NewSystem", S),
% systemAddDrive(S, "C",  "OS", 10000000000, S2),
% systemAddDrive(S2, "C",  "OS2", 123, S3).


systemAddDrive(System, Unidad, Nombre, Capacidad, UpdatedSystem) :-
   letterDoesntExistsInSystem(Unidad, System), % Verifico que no existe un drive con la misma letra
   drive(Unidad, Nombre, Capacidad, NewDrive),
   getDrives(System, CurrentDrives),
   setAddNewDriveInDrives(NewDrive, CurrentDrives, UpdatedDrives),
   setDrives(System, UpdatedDrives, UpdatedSystem).


% RF 3. register
% system("NewSystem", S),
% systemRegister(S, "user1", S2).
% system("NewSystem", S),
% systemAddDrive(S, "C",  "OS", 10000000000, S2),
% systemRegister(S2, "user1", S3).
systemRegister(System, User, UpdatedSystem) :-
   setAddUserInSystem(System, User, UpdatedSystem).



systemLogin(System, User, UpdatedSystem) :-
    getUsers(System, Users),
    existsUser(User,Users),
    setLogin(System, User, UpdatedSystem).


%systemSwitchDrive(S5, "C", S6),
 systemSwitchDrive(System, Drive, UpdatedSystem) :-
    getLogged(System, Logged),
    Logged is 1,
    setSwitchDrive(System, Drive, UpdatedSystem).

%systemMkdir(S6, "folder1", S7), 
systemMkdir(System, Folder, Updatedsystem) :-
    getUserLogged(System, Userlogged),
    getCurrentDrive(System, Currentdrive),
    getCurrentPath(System, Currentpath),
    folder(Folder, Userlogged, Currentdrive, Currentpath, Newelemento),
	getFolders(System, CurrentFolders),
	setNewElementoinElementos(Newelemento, CurrentFolders, UpdatedFolders),
    setFolder(System, UpdatedFolders, Updatedsystem).

getFolders(System, Currentfolders) :-
    filesystem(_, _, _, _, _, _, _,  Currentfolders,_,_, System).

getFiles(System, CurrentFiles) :-
    filesystem(_, _, _, _, _, _, _,  _,CurrentFiles,_, System).
    
setNewElementoinElementos(Newelemento, Currentelementos, UpdatedElementos) :-
   append(Currentelementos, [Newelemento], UpdatedElementos).

setFolder(System, UpdatedFolders, UpdatedSystem) :-
   filesystem(Nombre,Users,Drives, Currentuser, Currentdrive, Currentpath, Logged, _, Files,TimeStamp, System),
   filesystem(Nombre, Users, Drives, Currentuser, Currentdrive, Currentpath, Logged, UpdatedFolders, Files, TimeStamp, UpdatedSystem).

setFile(System, UpdatedFiles, UpdatedSystem) :-
   filesystem(Nombre,Users,Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, _,TimeStamp, System),
   filesystem(Nombre, Users, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, UpdatedFiles, TimeStamp, UpdatedSystem).


folder(Folder,Userlogged, Currentdrive, Currentpath,[Folder, Userlogged, Currentdrive, Currentpath]).


% name X users X drives X current-user X current-drive X current-path X logged X elementos X date.    
 getUserLogged(System, Userlogged) :-
    filesystem(_, _, _, Userlogged, _, _, _, _, _,_, System).

 getCurrentDrive(System, Currentdrive) :-
    filesystem(_, _, _, _, Currentdrive, _, _, _, _,_, System).

 getCurrentPath(System, Currentpath) :-
    filesystem(_, _, _, _, _, Currentpath, _, _, _,_, System).

%systemCd(S8, "folder1", S9),  utilizando dos puntos
systemCd(System, Target, UpdatedSystem) :-
    es_igual(Target, ".."),
    write('Es   correcto  con ..').

%systemCd(S8, "folder1", S9),  utilizando Salash
systemCd(System, Target, UpdatedSystem) :-
    es_igual(Target, "/"),
    write('Es   correcto  con /////').

%systemCd(S8, "folder1", S9),  utilizando cualquier cosa menos dospuntos y salash
systemCd(System, Target, UpdatedSystem) :-
    es_distinto(Target, ".."),
    es_distinto(Target, "/"),
    esPrimeroDistinto(Target,/),
    getFolders(System, CurrentFolders),
    exists(Target, CurrentFolders),
    setCurrentPath(System, Target, UpdatedSystem).
    

   
systemCd(System, Target, UpdatedSystem):- 
	esPrimeroIgual(Target, /),
	eliminarPrimero(Target, NewTarget),
    getFolders(System, CurrentFolders),
    toString(NewTarget, SNewTarget),
    exists(SNewTarget, CurrentFolders),
    setCurrentPath(System, SNewTarget, UpdatedSystem).

toString(Atom, String) :-
    atom_string(Atom, String).

% Regla para eliminar el primer carácter de un string
eliminarPrimero(Target, NewTarget) :-
    sub_atom(Target, 1, _, 0, NewTarget).

esPrimeroDistinto(String, Caracter) :-
    sub_atom(String, 0, 1, _, PrimerCaracter),
    PrimerCaracter \= Caracter.
   

esPrimeroIgual(String, Caracter):-
    sub_atom(String, 0, 1, _, PrimerCaracter),
    PrimerCaracter = Caracter.
    

setCurrentPath(System, NewCurrentPath, UpdatedSystem) :-
   filesystem(Nombre,Users,Drives, Currentuser, Currentdrive, _, Logged, Folders, Files, TimeStamp, System),
   filesystem(Nombre, Users, Drives, Currentuser, Currentdrive, NewCurrentPath, Logged, Folders, Files, TimeStamp, UpdatedSystem).
	
es_igual(X, Y) :- 
    X = Y.

es_distinto(X, Y) :- 
    X \= Y.

systemLogout(System, UpdatedSystem) :-
    getLogged(System, Logged),
    Logged is 1,
    setLogout(System, "", UpdatedSystem).
	
setLogout(System, User, UpdatedSystem) :-
   filesystem(Nombre,Users, Drives, _, _, _,_ , Folders,Files, TimeStamp, System),
   filesystem(Nombre, Users, Drives, User, "", "", 0, Folders, Files, TimeStamp, UpdatedSystem).





file(Nombre, Contenido, File) :-
    makeFile(Nombre, Contenido, File).

makeFile(Nombre, Contenido,[Nombre, Contenido]).


systemAddFile(System, F1, UpdatedSystem) :-
    getUserLogged(System, Userlogged),
    getCurrentDrive(System, Currentdrive),
    getCurrentPath(System, Currentpath),
    append(F1, [Userlogged], UpdatedFile),
    append(UpdatedFile, [Currentdrive], UpdatedFile2),
    append(UpdatedFile2, [Currentpath], Newelement),
    getFiles(System, CurrentFiles),
    setNewElementoinElementos(Newelement, CurrentFiles, UpdatedFiles),
    setFile(System, UpdatedFiles, UpdatedSystem).