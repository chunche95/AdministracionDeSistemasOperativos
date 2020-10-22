select countrY_id, country_name, region_id, 
    DECODE(
        REGION_ID, 1, 'Europa',
                    2, 'América',
                    3, 'Asia',
                    'Otro')
    ) Region
from countries;
