-module(mesh_seed_data).
-export([get_sovereign_architects/0, get_co_founders/0, get_entities/0, seed_all/0]).

% ============================================
% SOVEREIGN ARCHITECT
% ============================================
get_sovereign_architects() ->
    [
        #{
            id => <<"sovereign-arch-001">>,
            name => <<"Mandlenkosi Vundla">>,
            title => <<"Sovereign Architect">>,
            location => <<"Johannesburg, South Africa">>,
            trust_score => 100,
            role => <<"Founder & Vision">>,
            status => <<"active">>
        }
    ].

% ============================================
% CO-FOUNDERS
% ============================================
get_co_founders() ->
    [
        #{
            id => <<"co-founder-001">>,
            name => <<"Theodore Swarts">>,
            title => <<"Co-Founder">>,
            location => <<"Cape Town, South Africa">>,
            trust_score => 98,
            role => <<"Technical Strategy">>,
            status => <<"active">>
        },
        #{
            id => <<"co-founder-002">>,
            name => <<"Sempi Mvala">>,
            title => <<"Co-Founder">>,
            location => <<"Johannesburg, South Africa">>,
            trust_score => 97,
            role => <<"Operations & Scale">>,
            status => <<"active">>
        },
        #{
            id => <<"co-founder-003">>,
            name => <<"Mrs Codex">>,
            title => <<"Co-Founder">>,
            location => <<"Global">>,
            trust_score => 99,
            role => <<"Knowledge Architecture">>,
            status => <<"active">>
        }
    ].

% ============================================
% MAJOR ENTITIES DATABASE
% ============================================
get_entities() ->
    % TOP GLOBAL TECH LEADERS
    Leaders = [
        #{id => <<"person-mark-zuckerberg">>, name => <<"Mark Zuckerberg">>, type => <<"tech_founder">>, company => <<"Meta">>, net_worth => 200000000000, region => <<"USA">>},
        #{id => <<"person-elon-musk">>, name => <<"Elon Musk">>, type => <<"tech_founder">>, company => <<"Tesla, SpaceX">>, net_worth => 250000000000, region => <<"USA">>},
        #{id => <<"person-bill-gates">>, name => <<"Bill Gates">>, type => <<"tech_founder">>, company => <<"Microsoft">>, net_worth => 100000000000, region => <<"USA">>},
        #{id => <<"person-queen-elizabeth">>, name => <<"Queen Elizabeth II">>, type => <<"royalty">>, country => <<"United Kingdom">>, net_worth => 88000000000, region => <<"Europe">>}
    ],

    % TOP GLOBAL COMPANIES (Sample - Top 100 by market cap)
    GlobalCompanies = [
        #{id => <<"company-microsoft">>, name => <<"Microsoft">>, type => <<"tech">>, market_cap => 3300000000000, region => <<"USA">>},
        #{id => <<"company-apple">>, name => <<"Apple">>, type => <<"tech">>, market_cap => 2800000000000, region => <<"USA">>},
        #{id => <<"company-google">>, name => <<"Alphabet (Google)">>, type => <<"tech">>, market_cap => 1800000000000, region => <<"USA">>},
        #{id => <<"company-amazon">>, name => <<"Amazon">>, type => <<"tech">>, market_cap => 1600000000000, region => <<"USA">>},
        #{id => <<"company-nvidia">>, name => <<"NVIDIA">>, type => <<"tech">>, market_cap => 1200000000000, region => <<"USA">>},
        #{id => <<"company-tesla">>, name => <<"Tesla">>, type => <<"automotive_tech">>, market_cap => 900000000000, region => <<"USA">>},
        #{id => <<"company-saudi-aramco">>, name => <<"Saudi Aramco">>, type => <<"energy">>, market_cap => 2200000000000, region => <<"Saudi Arabia">>},
        #{id => <<"company-berkshire-hathaway">>, name => <<"Berkshire Hathaway">>, type => <<"finance">>, market_cap => 800000000000, region => <<"USA">>}
    ],

    % TECH GIANTS
    TechGiants = [
        #{id => <<"company-meta">>, name => <<"Meta">>, type => <<"social_tech">>, market_cap => 900000000000, region => <<"USA">>},
        #{id => <<"company-ibm">>, name => <<"IBM">>, type => <<"enterprise_tech">>, market_cap => 220000000000, region => <<"USA">>},
        #{id => <<"company-intel">>, name => <<"Intel">>, type => <<"semiconductors">>, market_cap => 250000000000, region => <<"USA">>},
        #{id => <<"company-oracle">>, name => <<"Oracle">>, type => <<"enterprise_software">>, market_cap => 340000000000, region => <<"USA">>}
    ],

    % FINANCIAL INSTITUTIONS (Banks, Top 500)
    FinancialInstitutions = [
        #{id => <<"bank-jpmorgan">>, name => <<"JPMorgan Chase">>, type => <<"bank">>, market_cap => 500000000000, region => <<"USA">>},
        #{id => <<"bank-bofa">>, name => <<"Bank of America">>, type => <<"bank">>, market_cap => 300000000000, region => <<"USA">>},
        #{id => <<"bank-hsbc">>, name => <<"HSBC">>, type => <<"bank">>, market_cap => 200000000000, region => <<"UK">>},
        #{id => <<"bank-icbc">>, name => <<"Industrial and Commercial Bank of China">>, type => <<"bank">>, market_cap => 280000000000, region => <<"China">>},
        #{id => <<"bank-standard-bank">>, name => <<"Standard Bank">>, type => <<"bank">>, market_cap => 25000000000, region => <<"South Africa">>},
        #{id => <<"bank-nedbank">>, name => <<"Nedbank">>, type => <<"bank">>, market_cap => 18000000000, region => <<"South Africa">>},
        #{id => <<"bank-firstrand">>, name => <<"FirstRand Bank">>, type => <<"bank">>, market_cap => 32000000000, region => <<"South Africa">>},
        #{id => <<"bank-capitec">>, name => <<"Capitec Bank">>, type => <<"bank">>, market_cap => 12000000000, region => <<"South Africa">>}
    ],

    % MINING COMPANIES (Top 2000)
    MiningCompanies = [
        #{id => <<"mining-de-beers">>, name => <<"De Beers">>, type => <<"diamonds">>, commodity => <<"diamonds">>, revenue => 8000000000, region => <<"South Africa">>},
        #{id => <<"mining-anglo-american">>, name => <<"Anglo American">>, type => <<"diversified">>, commodity => <<"multiple">>, revenue => 36000000000, region => <<"South Africa">>},
        #{id => <<"mining-anglogold">>, name => <<"AngloGold Ashanti">>, type => <<"gold">>, commodity => <<"gold">>, revenue => 9000000000, region => <<"South Africa">>},
        #{id => <<"mining-sibanye-gold">>, name => <<"Sibanye Stillwater">>, type => <<"gold_platinum">>, commodity => <<"gold, platinum">>, revenue => 8000000000, region => <<"South Africa">>},
        #{id => <<"mining-bhp">>, name => <<"BHP Group">>, type => <<"diversified">>, commodity => <<"multiple">>, revenue => 65000000000, region => <<"Australia">>},
        #{id => <<"mining-rio-tinto">>, name => <<"Rio Tinto">>, type => <<"diversified">>, commodity => <<"multiple">>, revenue => 50000000000, region => <<"Australia">>}
    ],

    % FINTECH & AUTOMOTIVE
    Industries = [
        % Automotive (Top 500)
        #{id => <<"auto-tesla">>, name => <<"Tesla">>, type => <<"electric_vehicles">>, market_cap => 900000000000, region => <<"USA">>},
        #{id => <<"auto-toyota">>, name => <<"Toyota">>, type => <<"vehicles">>, market_cap => 250000000000, region => <<"Japan">>},
        #{id => <<"auto-volkswagen">>, name => <<"Volkswagen">>, type => <<"vehicles">>, market_cap => 100000000000, region => <<"Germany">>},
        % Fintech
        #{id => <<"fintech-stripe">>, name => <<"Stripe">>, type => <<"fintech">>, valuation => 95000000000, region => <<"Global">>},
        #{id => <<"fintech-square">>, name => <<"Block Inc (Square)">>, type => <<"fintech">>, market_cap => 60000000000, region => <<"USA">>},
        #{id => <<"fintech-paypal">>, name => <<"PayPal">>, type => <<"fintech">>, market_cap => 80000000000, region => <<"USA">>}
    ],

    % AFRICAN ENTITIES
    African = [
        #{id => <<"corp-uvu-africa">>, name => <<"UVU Africa">>, type => <<"education_tech">>, location => <<"South Africa">>, focus => <<"digital_skills">>},
        #{id => <<"corp-alx-africa">>, name => <<"ALX Africa">>, type => <<"education_tech">>, location => <<"South Africa">>, focus => <<"software_engineering">>},
        #{id => <<"corp-capaciti">>, name => <<"Capaciti">>, type => <<"education_tech">>, location => <<"South Africa">>, focus => <<"digital_skills">>},
        #{id => <<"org-sparrow-village">>, name => <<"Sparrow Rainbow Village">>, type => <<"community">>, location => <<"South Africa">>, focus => <<"community_development">>},
        #{id => <<"org-talisman-foundation">>, name => <<"Talisman Foundation">>, type => <<"ngo">>, location => <<"South Africa">>, focus => <<"social_impact">>}
    ],

    % EDUCATIONAL INSTITUTIONS
    Educational = [
        #{id => <<"school-ufs">>, name => <<"University of the Free State">>, type => <<"university">>, location => <<"Bloemfontein, South Africa">>, students => 40000},
        #{id => <<"school-kuloanong">>, name => <<"Kuloanong Secondary School">>, type => <<"secondary">>, location => <<"South Africa">>, students => 1200},
        #{id => <<"school-adelaide-thabo">>, name => <<"Adelaide Thabo School">>, type => <<"secondary">>, location => <<"South Africa">>, students => 800},
        #{id => <<"school-durban-deep-primary">>, name => <<"Durban Deep Primary School">>, type => <<"primary">>, location => <<"Johannesburg, South Africa">>, students => 600},
        #{id => <<"school-unified-primary">>, name => <<"Unified Primary School">>, type => <<"primary">>, location => <<"South Africa">>, students => 750},
        #{id => <<"school-marlborton-primary">>, name => <<"Marlborton Primary School">>, type => <<"primary">>, location => <<"South Africa">>, students => 550},
        #{id => <<"school-graceworld-secondary">>, name => <<"Graceworld Secondary School">>, type => <<"secondary">>, location => <<"South Africa">>, students => 950}
    ],

    % CULTURAL & LINEAGE ENTITIES
    Cultural = [
        #{id => <<"lineage-vundla">>, name => <<"Vundla Lineage">>, type => <<"family_lineage">>, region => <<"South Africa">>, heritage => <<"Zulu">>},
        #{id => <<"lineage-moyo">>, name => <<"Moyo Lineage">>, type => <<"family_lineage">>, region => <<"South Africa">>, heritage => <<"Zulu">>},
        #{id => <<"lineage-chigwada">>, name => <<"Chigwada Lineage">>, type => <<"family_lineage">>, region => <<"South Africa">>, heritage => <<"Sotho">>},
        #{id => <<"lineage-oppenheimer">>, name => <<"Oppenheimer Family">>, type => <<"family_lineage">>, region => <<"South Africa">>, heritage => <<"Diamond Legacy">>},
        #{id => <<"person-cyril-ramaphosa">>, name => <<"Cyril Ramaphosa">>, type => <<"political">>, position => <<"President of South Africa">>, net_worth => 550000000},
        #{id => <<"person-johan-rupert">>, name => <<"Johann Rupert">>, type => <<"business">>, company => <<"Richemont">>, net_worth => 11000000000}
    ],

    % MEDIA & ENTERTAINMENT
    Media = [
        #{id => <<"media-generation-legacy">>, name => <<"Generations The Legacy">>, type => <<"tv_series">>, country => <<"South Africa">>, genre => <<"drama">>},
        #{id => <<"media-herdboys">>, name => <<"The Herd Boys">>, type => <<"cultural_group">>, country => <<"South Africa">>, genre => <<"traditional">>}
    ],

    % OTHER NOTABLE ENTITIES
    Other = [
        #{id => <<"entity-wall-street">>, name => <<"Wall Street">>, type => <<"financial_center">>, location => <<"New York, USA">>, significance => <<"global_finance">>}
    ],

    Leaders ++ GlobalCompanies ++ TechGiants ++ FinancialInstitutions ++ 
    MiningCompanies ++ Industries ++ African ++ Educational ++ 
    Cultural ++ Media ++ Other.

% ============================================
% SEED ALL DATA
% ============================================
seed_all() ->
    SovereignArchitects = get_sovereign_architects(),
    CoFounders = get_co_founders(),
    Entities = get_entities(),
    
    {
        SovereignArchitects,
        CoFounders,
        Entities
    }.
