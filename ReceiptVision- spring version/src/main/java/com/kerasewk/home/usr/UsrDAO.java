package com.kerasewk.home.usr;

public interface UsrDAO {

	UsrDTO getUsr(UsrDTO usrDTO) throws Exception;

	int countUsrId(String usr_id) throws Exception;

	void regist(UsrDTO usrDTO) throws Exception;
}
