using MainService as service from '../srv/main';

// --- 1. Anotações para a Entidade Principal (Trainees) ---
annotate service.Trainees with @(UI: {
    // Cabeçalho da Página
    HeaderInfo             : {
        TypeName      : 'Trainee',
        TypeNamePlural: 'Trainees',
        Title         : {
            $Type: 'UI.DataField',
            Value: firstName
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: lastName
        }
    },

    // Filtros da Tela Inicial (List Report)
    SelectionFields        : [
        firstName,
        lastName,
        area_ID,
        mentor_ID
    ],

    // Colunas da Tabela Inicial (List Report)
    LineItem               : [
        {
            $Type: 'UI.DataField',
            Value: firstName,
            Label: 'Nome'
        },
        {
            $Type: 'UI.DataField',
            Value: lastName,
            Label: 'Sobrenome'
        },
        {
            $Type: 'UI.DataField',
            Value: area.name,
            Label: 'Área'
        },
        {
            $Type: 'UI.DataField',
            Value: allocationStart,
            Label: 'Início Alocação'
        },
        {
            $Type: 'UI.DataField',
            Value: allocationEnd,
            Label: 'Fim Alocação'
        },
        {
            $Type: 'UI.DataField',
            Value: mentor.firstName,
            Label: 'Nome Mentor'
        } // <-- CORRIGIDO AQUI
    ],

    // Estrutura da Página de Detalhes (Object Page)
    Facets                 : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneralInfoFacet',
            Label : 'Informações Gerais',
            Target: '@UI.FieldGroup#GeneralInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'CoursesFacet',
            Label : 'Cursos Designados',
            Target: 'courses/@UI.LineItem' // Aponta para a tabela filha de cursos
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'ProjectsFacet',
            Label : 'Projetos Participados',
            Target: 'projects/@UI.LineItem' // Aponta para a tabela filha de projetos
        }
    ],

    // Agrupamento de Campos para a aba "Informações Gerais"
    FieldGroup #GeneralInfo: {Data: [
        {
            $Type: 'UI.DataField',
            Value: firstName
        },
        {
            $Type: 'UI.DataField',
            Value: lastName
        },
        {
            $Type: 'UI.DataField',
            Value: email
        },
        {
            $Type: 'UI.DataField',
            Value: area_ID,
            Label: 'Área'
        },
        {
            $Type: 'UI.DataField',
            Value: mentor_ID,
            Label: 'Mentor'
        },
        {
            $Type: 'UI.DataField',
            Value: allocationStart
        },
        {
            $Type: 'UI.DataField',
            Value: allocationEnd
        }
    ]}
});

// --- 2. Anotações para a Tabela Filha de Cursos ---
annotate service.TraineeCourses with @(UI: {LineItem: [
    {
        $Type: 'UI.DataField',
        Value: course_ID,
        Label: 'Curso'
    },
    {
        $Type: 'UI.DataField',
        Value: progress,
        Label: 'Progresso (%)'
    },
    {
        $Type: 'UI.DataField',
        Value: status,
        Label: 'Status'
    }
]});

// --- 3. Anotações para a Tabela Filha de Projetos ---
annotate service.TraineeProjects with @(UI: {LineItem: [
    {
        $Type: 'UI.DataField',
        Value: project_ID,
        Label: 'Projeto'
    },
    {
        $Type: 'UI.DataField',
        Value: role,
        Label: 'Papel'
    }
]});

// --- 4. Configuração dos Dropdowns (Value Helps) ---
// Isso permite que você selecione Áreas, Mentores, Cursos e Projetos a partir de uma lista ao invés de digitar o ID.
annotate service.Trainees with {
    area   @(Common.ValueList: {
        CollectionPath: 'Areas',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: area_ID,
                ValueListProperty: 'ID'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name'
            }
        ]
    });
    mentor @(Common.ValueList: {
        CollectionPath: 'Mentors',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: mentor_ID,
                ValueListProperty: 'ID'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'firstName'
            }, // <-- CORRIGIDO AQUI
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'lastName'
            } // <-- (Opcional) Mostra o sobrenome na busca também
        ]
    });
};

annotate service.TraineeCourses with {
    course @(Common.ValueList: {
        CollectionPath: 'Courses',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: course_ID,
                ValueListProperty: 'ID'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'title'
            }
        ]
    });
};

annotate service.TraineeProjects with {
    project @(Common.ValueList: {
        CollectionPath: 'Projects',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: project_ID,
                ValueListProperty: 'ID'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name'
            }
        ]
    });
};
