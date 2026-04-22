-- 1: Una relacion muchos a muchos se refiere a cuando un tipo de tabla puede tener mas de uno de otro tipo y vice versa, en este caso las asignaciones pueden tener muchos agentes y un agente puede tener muchas asignaciones a la vez
-- 2: Una vista es una consulta a la cual se puede acceder facilmente en cualquier momento en otra consulta. Para poder ver las horas dedicadas por incidente es necesario juntar las tablas incidentes y asignaciones para asi obtener el id de un incidente y mostrar sus horas asociadas en la tabla de asignaciones 
-- 3:Las exepciones predefinidas son las que pueden ocurrer con ciertas funciones de sql y se manejan al final del codigo con WHEN y el nombre de la exepcion y su accion. para manejar un NO_DATA_FOUND al final del codigo, en la seccion EXEPTION usar WHEN_NO_DATA_FOUND y la linea siguiente la accion a realizar como un mensaje dbms
-- 4:

--1:

DECLARE
    CURSOR c_agentes_esp IS
        SELECT (Agentes.NOMBRE, Agentes.ESPECIALIDAD, Asignaciones.Horas)
        FROM Agentes
        JOIN ASIGNACIONES ON Asignaciones.AGENTEID = Agentes.AGENTEID
        WHERE Asignaciones.Horas >30;
    v_agente VARCHAR2(50);
    v_esp VARCHAR2(50);
    v_horas NUMBER; 
    FOR UPDATE;
BEGIN

    
    OPEN c_agentes_esp;
    LOOP
        FETCH c_agentes_esp INTO (v_agente,v_esp_v_horas);
        EXIT WHEN c_agentes_esp%NOTFOUND;


        
        DBMS_OUTPUT.PUT_LINE('Agente: ' || v_agente || ' Especialidad: ' || v_esp || );

    END LOOP;
    CLOSE c_agentes_esp;
END;

