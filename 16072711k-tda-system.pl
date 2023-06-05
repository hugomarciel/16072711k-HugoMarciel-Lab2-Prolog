
%===========================================================================================================
%------------------------------------------------ TDA FS ------------------------------------------------------------------
%=======================================================================================================

%% ----------------------------------------------Constructores



% filesystem/4: constructor de filesystem que usa el timestamp, solo lo uso para el RF1
% name X users X drives X current-user X current-drive Xcurrent-path X logged X folders X Files X date.



% Descripción: Crea un sistema de archivos con el nombre especificado y guarda la fecha y hora actual en el TimeStamp.
% Meta Principal: Nombre, Users, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp
% Meta Secundaria: get_time
filesystem(Nombre, Users , Drives,  Currentuser, Currentdrive, Currentpath, Logged, Folders, Files,[Nombre,  Users, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp]) :-
   get_time(TimeStamp).

% Descripción: Crea un sistema de archivos con el nombre especificado y asigna el TimeStamp proporcionado.
% Meta Principal: Nombre, Users, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp
% Meta Secundaria: Ninguna
filesystem(Nombre, Users, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp, [Nombre,Users, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp]).

% Descripción: Crea un sistema de archivos con el nombre especificado y configura los valores iniciales para Users, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files.
% Meta Principal: Nombre, Sistema
% Meta Secundaria: filesystem
system(Nombre, Sistema) :-
   filesystem(Nombre, [], [], "","","","",[],[],Sistema).

%---------------------------------------------------------------------------------------------Selectores FS
%-----------------------------------------------


% Descripción: Obtiene la lista de unidades de disco disponibles en el sistema especificado.
% Meta Principal: System, Drives
% Meta Secundaria: filesystem
getDrives(System, Drives) :-
   filesystem(_, _, Drives, _, _, _, _, _, _,_, System).% uso el constructor que obtiene el timestamp

% Descripción: Obtiene la lista de usuarios disponibles en el sistema especificado.
% Meta Principal: System, Users
% Meta Secundaria: filesystem
getUsers(System, Users) :-
   filesystem(_, Users, _, _, _, _ , _, _ , _,_, System).

% Descripción: Obtiene el estado de inicio de sesión en el sistema especificado.
% Meta Principal: System, Logged
% Meta Secundaria: filesystem
getLogged(System, Logged) :-
   filesystem(_, _, _, _, _, _ , Logged, _ , _,_, System).


% Descripción: Obtiene la lista de carpetas actuales en el sistema especificado.
% Meta Principal: System, Currentfolders
% Meta Secundaria: filesystem
getFolders(System, Currentfolders) :-
    filesystem(_, _, _, _, _, _, _,  Currentfolders,_,_, System).

% Descripción: Obtiene la ruta actual en el sistema especificado.
% Meta Principal: System, CurrentPath
% Meta Secundaria: filesystem
getPath(System, CurrentPath) :-
    filesystem(_, _, _, _, _, CurrentPath, _, _,_,_, System).


% Descripción: Obtiene la unidad de disco actual en el sistema especificado.
% Meta Principal: System, CurrentDrive
% Meta Secundaria: filesystem
getDrive(System, CurrentDrive) :-
    filesystem(_, _, _, _, CurrentDrive, _, _, _,_,_, System).


% Descripción: Obtiene la lista de archivos actuales en el sistema especificado.
% Meta Principal: System, CurrentFiles
% Meta Secundaria: filesystem
getFiles(System, CurrentFiles) :-
    filesystem(_, _, _, _, _, _, _,  _,CurrentFiles,_, System).

% Descripción: Obtiene el usuario que ha iniciado sesión en el sistema especificado.
% Meta Principal: System, Userlogged
% Meta Secundaria: filesystem    
getUserLogged(System, Userlogged) :-
    filesystem(_, _, _, Userlogged, _, _, _, _, _,_, System).


% Descripción: Obtiene la unidad de disco actual en el sistema especificado.
% Meta Principal: System, Currentdrive
% Meta Secundaria: filesystem
getCurrentDrive(System, Currentdrive) :-
    filesystem(_, _, _, _, Currentdrive, _, _, _, _,_, System).


% Descripción: Obtiene la ruta actual en el sistema especificado.
% Meta Principal: System, Currentpath
% Meta Secundaria: filesystem
getCurrentPath(System, Currentpath) :-
    filesystem(_, _, _, _, _, Currentpath, _, _, _,_, System).


% Descripción: Obtiene los elementos (carpetas y archivos) del sistema especificado en la unidad de disco, usuario y ruta actual.
% Meta Principal: System, CurrentDrive, CurrentUser, CurrentPath, Folders, Files
% Meta Secundaria: filesystem
getElementos(System,CurrentDrive, CurrentUser,CurrentPath, Folders, Files) :-
    filesystem(_, _, _, CurrentUser, CurrentDrive, CurrentPath, _,  Folders,Files,_, System).


%------------------------------------------------------------------------------------------Modificadores FS
%------------------------------------------------------------------------------------------Modificadores FS

% Descripción: Actualiza la lista de unidades de disco en el sistema especificado.
% Meta Principal: System, UpdatedDrives, UpdatedSystem
% Meta Secundaria: filesystem
setDrives(System, UpdatedDrives, UpdatedSystem) :-
   filesystem(Nombre,Users,_, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp, System),
   filesystem(Nombre, Users, UpdatedDrives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp, UpdatedSystem).

% Descripción: Establece el inicio de sesión para el usuario especificado en el sistema.
% Meta Principal: System, User, UpdatedSystem
% Meta Secundaria: filesystem
setLogin(System, User, UpdatedSystem) :-
   filesystem(Nombre,Users, Drives, _, _, _,_ , Folders, Files, TimeStamp, System),
   filesystem(Nombre, Users, Drives, User, "C:/", "C:/", 1, Folders, Files, TimeStamp, UpdatedSystem).


% Descripción: Cambia la unidad de disco actual en el sistema especificado.
% Meta Principal: System, Newdrive, UpdatedSystem
% Meta Secundaria: driveFormat, filesystem
setSwitchDrive(System, Newdrive, UpdatedSystem) :-
   driveFormat(Newdrive, NewDriveFormat),
   filesystem(Nombre,Users, Drives, Currentuser, _, _,Logged , Folders, Files, TimeStamp, System),
   filesystem(Nombre, Users, Drives, Currentuser, NewDriveFormat, NewDriveFormat, Logged, Folders, Files, TimeStamp, UpdatedSystem).


% Descripción: Agrega un usuario a la lista de usuarios actualizada.
% Meta Principal: Users, User, UpdatedUsers
% Meta Secundaria: append
setAddUserInUsers(Users, User, UpdatedUsers) :-
   append(Users, [User], UpdatedUsers).

% Descripción: Actualiza la lista de usuarios en el sistema especificado.
% Meta Principal: System, UpdatedUsers, UpdatedSystem
% Meta Secundaria: filesystem
setUsers(System, UpdatedUsers, UpdatedSystem) :-
   filesystem(Nombre, _, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp, System),
   filesystem(Nombre,  UpdatedUsers, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, Files, TimeStamp, UpdatedSystem).

% Descripción: Agrega un usuario tanto en la lista de usuarios como en el sistema actualizado.
% Meta Principal: System, User, UpdatedSystem
% Meta Secundaria: getUsers, setAddUserInUsers, setUsers
setAddUserInSystem(System, User, UpdatedSystem) :-
   getUsers(System, Users),
   setAddUserInUsers(Users, User, UpdatedUsers),
   setUsers(System, UpdatedUsers, UpdatedSystem).


% Descripción: Actualiza la lista de carpetas en el sistema especificado.
% Meta Principal: System, UpdatedFolders, UpdatedSystem
% Meta Secundaria: filesystem
setFolder(System, UpdatedFolders, UpdatedSystem) :-
   filesystem(Nombre,Users,Drives, Currentuser, Currentdrive, Currentpath, Logged, _, Files,TimeStamp, System),
   filesystem(Nombre, Users, Drives, Currentuser, Currentdrive, Currentpath, Logged, UpdatedFolders, Files, TimeStamp, UpdatedSystem).

% Descripción: Actualiza la lista de archivos en el sistema especificado.
% Meta Principal: System, UpdatedFiles, UpdatedSystem
% Meta Secundaria: filesystem
setFile(System, UpdatedFiles, UpdatedSystem) :-
   filesystem(Nombre,Users,Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, _,TimeStamp, System),
   filesystem(Nombre, Users, Drives, Currentuser, Currentdrive, Currentpath, Logged, Folders, UpdatedFiles, TimeStamp, UpdatedSystem).

% Descripción: Establece la ruta actual en el sistema especificado.
% Meta Principal: System, NewCurrentPath, UpdatedSystem
% Meta Secundaria: filesystem
setCurrentPath(System, NewCurrentPath, UpdatedSystem) :-
   filesystem(Nombre,Users,Drives, Currentuser, Currentdrive, _, Logged, Folders, Files, TimeStamp, System),
   filesystem(Nombre, Users, Drives, Currentuser, Currentdrive, NewCurrentPath, Logged, Folders, Files, TimeStamp, UpdatedSystem).

% Descripción: Realiza el cierre de sesión de un usuario en el sistema dado.
% Meta Principal: System, User, UpdatedSystem
% Meta Secundaria: filesystem	
setLogout(System, User, UpdatedSystem) :-
   filesystem(Nombre,Users, Drives, _, _, _,_ , Folders,Files, TimeStamp, System),
   filesystem(Nombre, Users, Drives, User, "", "", 0, Folders, Files, TimeStamp, UpdatedSystem).





%==============================================================================================
%----------------------------------------------Pertenencia FS

% Descripción: Verifica si el elemento dado se encuentra en la primera lista de la lista principal.
% Meta Principal: Elemento, ListaInterna
% Meta Secundaria: member
exists(Elemento, [ListaInterna|_]) :-
   member(Elemento, ListaInterna).
% Descripción: Verifica si el elemento dado se encuentra en alguna de las listas restantes de la lista principal.
% Meta Principal: Elemento, RestoListas
% Meta Secundaria: exists
exists(Elemento, [_|RestoListas]) :-
   exists(Elemento, RestoListas).





% Descripción: Verifica si el usuario dado se encuentra en la lista de usuarios.
% Meta Principal: User, Users
% Meta Secundaria: member
existsUser(User, Users) :-
   member(User, Users). % \+



%----------------------------------------------Otros FS


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

% Descripción: Realiza el cierre de sesión en el sistema dado si hay un usuario actualmente conectado.
% Meta Principal: System, UpdatedSystem
% Meta Secundaria: getLogged, setLogout
systemLogout(System, UpdatedSystem) :-
    getLogged(System, Logged),
    Logged is 1,
    setLogout(System, "", UpdatedSystem).





%===========================================================================================================================
%---------------------------------------------------TDA Drive --------------------------------------------------
%===============================================================================================================

%----------------------------------------------------Constructor TDA Drive
% Descripción: Representa un disco o unidad de almacenamiento con sus atributos: unidad, nombre y capacidad.
% Meta Principal: Unidad, Nombre, Capacidad
% Meta Secundaria: Ninguna
drive(Unidad, Nombre, Capacidad, [Unidad, Nombre, Capacidad]).

%----------------------------------------------------Modificador TDA Drive

% Descripción: Agrega una nueva unidad de disco a la lista de unidades de disco existentes.
% Meta Principal: NewDrive, Drives, UpdatedDrives
% Meta Secundaria: append
setAddNewDriveInDrives(NewDrive, Drives, UpdatedDrives) :-
   append(Drives, [NewDrive], UpdatedDrives).


%----------------------------------------------------Selector TDA Drive






%----------------------------------------------------Pertenencia TDA Drive
% Descripción: Verifica si la unidad de disco especificada no existe en el sistema dado.
% Meta Principal: Unidad, System
% Meta Secundaria: filesystem, exists
letterDoesntExistsInSystem(Unidad, System) :-
   filesystem(_, _, Drives, _, _, _, _, _, _,_, System),
    \+ exists(Unidad, Drives). %  \+ es not



%----------------------------------------------------Otros TDA Drive


% Descripción: Agrega una nueva unidad de disco al sistema dado, verificando que no exista una unidad con la misma letra.
% Meta Principal: System, Unidad, Nombre, Capacidad, UpdatedSystem
% Meta Secundaria: letterDoesntExistsInSystem, driveFormat, drive, getDrives, setAddNewDriveInDrives, setDrives
systemAddDrive(System, Unidad, Nombre, Capacidad, UpdatedSystem) :-
   letterDoesntExistsInSystem(Unidad, System), % Verifico que no existe un drive con la misma letra
   driveFormat(Unidad, NewUnit),
   drive(NewUnit, Nombre, Capacidad, NewDrive),
   getDrives(System, CurrentDrives),
   setAddNewDriveInDrives(NewDrive, CurrentDrives, UpdatedDrives),
   setDrives(System, UpdatedDrives, UpdatedSystem).

% Descripción: Formatea la unidad de disco añadiendo ":" y "/" al final de la letra de la unidad.
% Meta Principal: Drive, NewDrive
% Meta Secundaria: string_length, string_concat
driveFormat(Drive, NewDrive) :-
    string_length(Drive, 1),
    string_concat(Drive, ":/", NewDrive).
% Descripción: Mantiene el formato de la unidad de disco si su longitud es igual a 3.
% Meta Principal: Drive, NewDrive
% Meta Secundaria: string_length    
driveFormat(Drive, NewDrive) :-
    string_length(Drive, 3),
    NewDrive = Drive.


    
 
    



%=================================================================================================================
%---------------------------------------------------TDA Folders --------------------------------------------------
%====================================================================================================


%----------------------------------------------------Constructor TDA Folder

% Descripción: Define una carpeta con sus atributos correspondientes.
% Meta Principal: Folder, Userlogged, Currentdrive, Currentpath
% Meta Secundaria: Ninguna
folder(Folder,Userlogged, Currentdrive, Currentpath,[Folder, Userlogged, Currentdrive, Currentpath]).




%----------------------------------------------------Modificador TDA Folder
% Descripción: Agrega un nuevo elemento a una lista existente.
% Meta Principal: Newelemento, Currentelementos, UpdatedElementos
% Meta Secundaria: append    
setNewElementoinLista(Newelemento, Currentelementos, UpdatedElementos) :-
   append(Currentelementos, [Newelemento], UpdatedElementos).




%----------------------------------------------------Otros TDA Folder
% Descripción: Crea un nuevo directorio en el sistema.
% Meta Principal: System, Folder, Updatedsystem
% Meta Secundaria: getUserLogged, getCurrentDrive, getCurrentPath, folder, getFolders, setNewElementoinLista, setFolder 
systemMkdir(System, Folder, Updatedsystem) :-
    getUserLogged(System, Userlogged),
    getCurrentDrive(System, Currentdrive),
    getCurrentPath(System, Currentpath),
    folder(Folder, Userlogged, Currentdrive, Currentpath, Newelemento),
	getFolders(System, CurrentFolders),
	setNewElementoinLista(Newelemento, CurrentFolders, UpdatedFolders),
    setFolder(System, UpdatedFolders, Updatedsystem).












%---------------------------------------------------TDA File --------------------------------------------------


%----------------------------------------------------------Constructor TDS File
% Descripción: Crea un archivo con el nombre y contenido especificados.
% Meta Principal: Nombre, Contenido, File
% Meta Secundaria: makeFile
file(Nombre, Contenido, File) :-
    makeFile(Nombre, Contenido, File).
% Descripción: Crea un archivo con el nombre y contenido especificados en forma de lista.
% Meta Principal: Nombre, Contenido, [Nombre, Contenido]
makeFile(Nombre, Contenido,[Nombre, Contenido]).
%------------------------------------------------------------Modificador TDA File

% Descripción: Elimina un archivo de la lista de archivos por su nombre.
% Meta Principal: Target, CurrentFiles, NewCurrentFiles
eliminaFileXNombre(Target, CurrentFiles, NewCurrentFiles) :-
    delete(CurrentFiles, [Target, _, _, _, _], NewCurrentFiles).

% Descripción: Agrega un nuevo archivo al sistema.
% Meta Principal: System, F1, UpdatedSystem
% Meta Secundaria: getUserLogged, getCurrentDrive, getCurrentPath, append, getFiles, setNewElementoinLista, setFile
systemAddFile(System, F1, UpdatedSystem) :-
    getUserLogged(System, Userlogged),
    getCurrentDrive(System, Currentdrive),
    getCurrentPath(System, Currentpath),
    append(F1, [Userlogged], UpdatedFile),
    append(UpdatedFile, [Currentdrive], UpdatedFile2),
    append(UpdatedFile2, [Currentpath], Newelement),
    getFiles(System, CurrentFiles),
    setNewElementoinLista(Newelement, CurrentFiles, UpdatedFiles),
    setFile(System, UpdatedFiles, UpdatedSystem).





%----------------------------------------------------------- Otros------------------------------------------------


% Descripción: Elimina un archivo del sistema.
% Meta Principal: System, Target, UpdatedSystem
% Meta Secundaria: getFiles, exists, eliminaTarget, setFile
systemDel(System, Target, UpdatedSystem):-
    getFiles(System, CurrentFiles),
    exists(Target, CurrentFiles),
    eliminaTarget(Target, CurrentFiles, Resultado),
    setFile(System, Resultado, UpdatedSystem).
    
    
% Descripción: Elimina todas las apariciones de un elemento objetivo en una lista de archivos.
% Meta Principal: Target, CurrentFiles, Resultado
% Meta Secundaria: eliminar_elemento_aux    
eliminaTarget(Target, CurrentFiles, Resultado) :-
    eliminar_elemento_aux(Target, CurrentFiles, [], Resultado).
% Descripción: Caso base de la recursión. Si la lista de archivos está vacía, el acumulador contiene el resultado.
% Meta Principal: _, [], Acumulador, Acumulador
% Meta Secundaria: Ninguna
eliminar_elemento_aux(_, [], Acumulador, Acumulador).
% Descripción: Si el elemento objetivo coincide con el primer elemento de una sublista, se omite esa sublista y se continúa con el resto de la lista de archivos.
% Meta Principal: Target, [[Target|_]|Resto], Acumulador, Resultado
% Meta Secundaria: eliminar_elemento_aux
eliminar_elemento_aux(Target, [[Target|_]|Resto], Acumulador, Resultado) :-
    eliminar_elemento_aux(Target, Resto, Acumulador, Resultado).
% Descripción: Si el elemento objetivo no coincide con el primer elemento de una sublista, se agrega esa sublista al acumulador y se continúa con el resto de la lista de archivos.
% Meta Principal: Target, [Cabecera|Resto], Acumulador, Resultado
% Meta Secundaria: eliminar_elemento_aux
eliminar_elemento_aux(Target, [Cabecera|Resto], Acumulador, Resultado) :-
    eliminar_elemento_aux(Target, Resto, [Cabecera|Acumulador], Resultado).



% copia el archivo foo.txt a la ruta D:/newFolder/
%systemCopy(S, “foo.txt”, “D:/newFolder/”, S1).
systemCopy(System, Target, Destiny, UpdatedSystem):-
    getFiles(System, CurrentFiles),
    existGetContentFile(Target, CurrentFiles, Content),
    getDataFromDestiny(Destiny, Drive, Path),
    getUserLogged(System, Userlogged),
    append([], [Target], UpdatedFile0),
    append(UpdatedFile0, [Content], UpdatedFile),
    append(UpdatedFile, [Userlogged], UpdatedFile1),
    append(UpdatedFile1, [Drive], UpdatedFile2),
    append(UpdatedFile2, [Path], Newelement),
    getFiles(System, CurrentFiles),
    setNewElementoinLista(Newelement, CurrentFiles, UpdatedFiles),
    setFile(System, UpdatedFiles, UpdatedSystem).




% Descripción: Busca el contenido de un archivo en una lista de archivos dado su nombre objetivo.
% Meta Principal: Target, CurrentFiles, Content
% Meta Secundaria: existGetContentFileHelper
existGetContentFile(Target, CurrentFiles, Content) :-
    existGetContentFileHelper(Target, CurrentFiles, Content).

% Descripción: Si el nombre objetivo coincide con el nombre de un archivo en la lista de archivos, se asigna el contenido de ese archivo a la variable Content.
% Meta Principal: Target, [[Nombre, Contenido, _, _, _] | _], Content
% Meta Secundaria: Ninguna
existGetContentFileHelper(Target, [[Nombre, Contenido, _, _, _] | _], Content) :-
    Nombre = Target,
    atom_string(Contenido, Content).
% Descripción: Si el nombre objetivo no coincide con el nombre de un archivo en la lista de archivos, se continúa buscando en el resto de la lista.
% Meta Principal: Target, [_ | Rest], Content
% Meta Secundaria: existGetContentFileHelper
existGetContentFileHelper(Target, [_ | Rest], Content) :-
    existGetContentFileHelper(Target, Rest, Content).



% Descripción: Extrae la información de unidad de disco (Drive) y ruta (Path) desde un destino dado.
% Meta Principal: Destiny, Drive, Path
% Meta Secundaria: Ninguna
getDataFromDestiny(Destiny, Drive, Path) :-
    sub_string(Destiny, 0, 3, _, Drive),
    sub_string(Destiny, 3, _, 0, Path).


% Descripción: Mueve un elemento especificado hacia un destino dado, actualizando el sistema resultante.
% Meta Principal: System, Target, Destiny, UpdatedSystem
% Meta Secundaria: getFiles, existGetContentFile, getDataFromDestiny, getUserLogged, append, eliminaFileXNombre, setNewElementoinLista, setFile
systemMove(System, Target, Destiny, UpdatedSystem):-
    getFiles(System, CurrentFiles),
    existGetContentFile(Target, CurrentFiles, Content),
    getDataFromDestiny(Destiny, Drive, Path),
    getUserLogged(System, Userlogged),
    append([], [Target], UpdatedFile0),
    append(UpdatedFile0, [Content], UpdatedFile),
    append(UpdatedFile, [Userlogged], UpdatedFile1),
    append(UpdatedFile1, [Drive], UpdatedFile2),
    append(UpdatedFile2, [Path], Newelement),
    %getFiles(System, CurrentFiles),
    eliminaFileXNombre(Target, CurrentFiles, NewCurrentFiles),
    setNewElementoinLista(Newelement, NewCurrentFiles, UpdatedFiles),
    setFile(System, UpdatedFiles, UpdatedSystem).




% Descripción: Renombra un archivo en el sistema.
% Meta Principal: System, Target, New, UpdatedSystem
% Meta Secundaria: getFiles, existGetContentFile, getDrive, getPath, getUserLogged, append, eliminaFileXNombre, setNewElementoinLista, setFile
systemRen(System, Target, New, UpdatedSystem ):-
    getFiles(System, CurrentFiles),
    existGetContentFile(Target, CurrentFiles, Content),
    getDrive(System, Drive),
    getPath(System, Path),
    getUserLogged(System, Userlogged),
    append([], [New], UpdatedFile0),
    append(UpdatedFile0, [Content], UpdatedFile),
    append(UpdatedFile, [Userlogged], UpdatedFile1),
    append(UpdatedFile1, [Drive], UpdatedFile2),
    append(UpdatedFile2, [Path], Newelement),
    %getFiles(System, CurrentFiles),
    eliminaFileXNombre(Target, CurrentFiles, NewCurrentFiles),
    setNewElementoinLista(Newelement, NewCurrentFiles, UpdatedFiles),
    setFile(System, UpdatedFiles, UpdatedSystem).







systemDir(System, Lista, Str) :-
    length(Lista, 0),
    getElementos(System,CurrentDrive, CurrentUser,CurrentPath, Folders, Files),
    filterXUDP(CurrentUser,CurrentDrive, CurrentPath, Folders, filteredFolders),
    write("Estos son los drivesn/"),
    write(Folders),
    write(Files).


%systemCd(S8, "folder1", S9),  utilizando dos puntos
systemCd(System, Target, UpdatedSystem) :-
    es_igual(Target, ".."),
    write('Es   correcto  con ..').

%systemCd(S8, "folder1", S9),  utilizando Salash
systemCd(System, Target, UpdatedSystem) :-
    es_igual(Target, "/"),
    write('Es   correcto  con /////').







% Descripción: Cambia el directorio actual del sistema a la ruta especificada.
% Meta Principal: System, Target, UpdatedSystem
% Meta Secundaria: es_distinto, getFolders, exists, setCurrentPath
systemCd(System, Target, UpdatedSystem) :-
    es_distinto(Target, ".."),
    es_distinto(Target, "/"),
    esPrimeroDistinto(Target,/),
    getFolders(System, CurrentFolders),
    exists(Target, CurrentFolders),
    setCurrentPath(System, Target, UpdatedSystem).
    

% Descripción: Cambia el directorio actual del sistema a la ruta especificada.
% Meta Principal: System, Target, UpdatedSystem
% Meta Secundaria: esPrimeroIgual, eliminarPrimero, getFolders, toString, exists, setCurrentPath   
systemCd(System, Target, UpdatedSystem):- 
	esPrimeroIgual(Target, /),
	eliminarPrimero(Target, NewTarget),
    getFolders(System, CurrentFolders),
    toString(NewTarget, SNewTarget),
    exists(SNewTarget, CurrentFolders),
    setCurrentPath(System, SNewTarget, UpdatedSystem).


% Descripción: Convierte un átomo en una cadena de caracteres.
% Meta Principal: Atom, String
% Meta Secundaria: atom_string
toString(Atom, String) :-
    atom_string(Atom, String).

% Descripción: Elimina el primer carácter de una cadena de caracteres.
% Meta Principal: Target, NewTarget
% Meta Secundaria: sub_atom
eliminarPrimero(Target, NewTarget) :-
    sub_atom(Target, 1, _, 0, NewTarget).

% Descripción: Verifica si el primer carácter de una cadena de caracteres es distinto al carácter dado.
% Meta Principal: String, Caracter
% Meta Secundaria: sub_atom, \=
esPrimeroDistinto(String, Caracter) :-
    sub_atom(String, 0, 1, _, PrimerCaracter),
    PrimerCaracter \= Caracter.
   
% Descripción: Verifica si el primer carácter de una cadena de caracteres es igual al carácter dado.
% Meta Principal: String, Caracter
% Meta Secundaria: sub_atom, =
esPrimeroIgual(String, Caracter):-
    sub_atom(String, 0, 1, _, PrimerCaracter),
    PrimerCaracter = Caracter.
    


% Descripción: Verifica si dos elementos son iguales.
% Meta Principal: X, Y
% Meta Secundaria: =	
es_igual(X, Y) :- 
    X = Y.

% Descripción: Verifica si dos elementos son distintos.
% Meta Principal: X, Y
% Meta Secundaria: \=
es_distinto(X, Y) :- 
    X \= Y.
