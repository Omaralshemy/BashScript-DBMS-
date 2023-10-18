DECLARE
   CURSOR BRANCH_CURSOR IS
      SELECT CITY_ID FROM BRANCHES;

   CURSOR EMP_CURSOR IS
      SELECT BRANCH_ID, EMPLOYEE_ID, EMPLOYEE_POSITION FROM BRANCH_EMPLOYEES;
   
   V_BRANCH_BONUS NUMBER (10, 2);
   V_CITY_ID NUMBER (4);
   V_EMP_ID NUMBER (4);
   V_BRANCH_ID  NUMBER (4);
   V_EMP_POSITION  VARCHAR2 (25);
   V_EMP_BONUS NUMBER (10, 2);
BEGIN
   FOR BRANCH_RECORD IN BRANCH_CURSOR
   LOOP
      V_CITY_ID := BRANCH_RECORD.CITY_ID ;
      V_BRANCH_BONUS := DEST_CITY_BONUS(V_CITY_ID);
      UPDATE_BRANCHS_PROC(V_CITY_ID, V_BRANCH_BONUS);
   END LOOP;

   FOR EMP_RECORD IN EMP_CURSOR
   LOOP
      V_EMP_ID := EMP_RECORD.EMPLOYEE_ID ;
      V_BRANCH_ID := EMP_RECORD.BRANCH_ID;
      V_EMP_POSITION := EMP_RECORD.EMPLOYEE_POSITION;

      V_EMP_BONUS := EMP_BONUS_FUNC(V_BRANCH_ID  , V_EMP_POSITION ,V_BRANCH_BONUS) ;

      UPDAET_EMP_BONUS_PROC(V_EMP_ID  , V_EMP_BONUS);
   END LOOP;
END;