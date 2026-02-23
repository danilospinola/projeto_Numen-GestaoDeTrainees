namespace traineeManagement;
using { cuid, managed } from '@sap/cds/common';

entity Trainees : cuid, managed {
    firstName      : String(50) @title: 'Nome';
    lastName       : String(50) @title: 'Sobrenome';
    email          : String(100) @title: 'E-mail';
    area           : Association to Areas @title: 'Área de Alocação';
    allocationStart: Date @title: 'Início da Alocação';
    allocationEnd  : Date @title: 'Fim da Alocação';
    mentor         : Association to Mentors @title: 'Mentor';
    courses        : Composition of many TraineeCourses on courses.trainee = $self;
    projects       : Composition of many TraineeProjects on projects.trainee = $self;
}

entity Areas : cuid {
    name           : String(50) @title: 'Nome da Área';
    description    : String(255) @title: 'Descrição';
}

entity Mentors : cuid {
    firstName           : String(50) @title: 'Nome do Mentor';
    lastName            : String(50) @title: 'Sobrenome do Mentor';
    email          : String(100) @title: 'E-mail do Mentor';
    role           : String(50) @title: 'Cargo';
}

entity Courses : cuid {
    title          : String(100) @title: 'Título do Curso';
    platform       : String(50) @title: 'Plataforma (ex: SAP Learning)';
}

entity TraineeCourses : cuid {
    trainee        : Association to Trainees;
    course         : Association to Courses @title: 'Curso';
    progress       : Integer default 0 @title: 'Progresso (%)';
    @title : 'Status do Curso'
    status         : String(20) enum {
        NotStarted = 'Não Iniciado';
        InProgress = 'Em Andamento';
        Completed  = 'Concluído';
    }
}

entity Projects : cuid {
    name           : String(100) @title: 'Nome do Projeto';
    client         : String(100) @title: 'Cliente / Área Interna';
}

entity TraineeProjects : cuid {
    trainee        : Association to Trainees;
    project        : Association to Projects @title: 'Projeto';
    @title : 'Papel no Projeto'
    role           : String(20) enum {
        Shadow     = 'Shadow';
        Working    = 'Trabalhando (Ativo)';
    } 
}