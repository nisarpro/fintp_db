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

--Function: findata.insertimgblobsqueue(inguid varchar, incorrelationid varchar, inbatchid varchar, inimageref varchar, inpayload bytea)

--DROP FUNCTION findata.insertimgblobsqueue(inguid varchar, incorrelationid varchar, inbatchid varchar, inimageref varchar, inpayload bytea);

CREATE OR REPLACE FUNCTION findata.insertimgblobsqueue
(
  IN  inguid           varchar,
  IN  incorrelationid  varchar,
  IN  inbatchid        varchar,
  IN  inimageref       varchar,
  IN  inpayload        bytea  
)
RETURNS void AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         08.May.2014, DenisaN 8380
  Description:     Inserts transaction attached image 
  Parameters:      inGuid - transaction identifier
                   inCorrelationid - trasaction correlation identifier 
                   inBatchID - batch identifier  
                   inImageref - image reference number / same as trx
                   inPayload  - image binary content
  Returns:       n/a
  Used:          FinTP/DI/CONN
***********************************************/   


BEGIN

insert into findata.blobsqueue(guid, correlationid, batchid, imageref, payload) 
                       values (inGuid, inCorrelationid, inBatchid, inImageref, inPayload);
    
                                   
EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while processing message: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.insertimgblobsqueue(inguid varchar, incorrelationid varchar, inbatchid varchar, inimageref varchar, inpayload bytea)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.insertimgblobsqueue(inguid varchar, incorrelationid varchar, inbatchid varchar, inimageref varchar, inpayload bytea)
TO findata;