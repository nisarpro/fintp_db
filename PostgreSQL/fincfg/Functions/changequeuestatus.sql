/*
* FinTP - Financial Transactions Processing Application
* Copyright (C) 2013 Business Information Systems (Allevo) S.R.L.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>
* or contact Allevo at : 031281 Bucuresti, 23C Calea Vitan, Romania,
* phone +40212554577, office@allevo.ro <mailto:office@allevo.ro>, www.allevo.ro.
*/


--Function: fincfg.changequeuestatus(inqueueid integer, instatus integer)

--DROP FUNCTION fincfg.changequeuestatus(inqueueid integer, instatus integer);

CREATE OR REPLACE FUNCTION fincfg.changequeuestatus
(
  IN  inqueueid  integer,
  IN  instatus   integer
)
RETURNS void AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         10.Jun.2013, DenisaN  - 7168
  Description:     Changes the status of a specified queue
  Parameters:      inQueueID - queue to be modified
                   inStatus - new status of the queue                    
  Returns:         n/a
  Used:            FinTP/BASE/RE
***********************************************/


BEGIN

   update  fincfg.queues   set   holdstatus = inStatus where  guid = inQueueID;
         

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while configuring queue: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION fincfg.changequeuestatus(inqueueid integer, instatus integer)
  OWNER TO fincfg;

GRANT EXECUTE
  ON FUNCTION fincfg.changequeuestatus(inqueueid integer, instatus integer)
TO fincfg;