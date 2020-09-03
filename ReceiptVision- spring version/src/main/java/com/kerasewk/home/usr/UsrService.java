package com.kerasewk.home.usr;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UsrService {

	@Autowired
	private UsrDAO usrDAO;

	public UsrDTO getUsr(UsrDTO usrDTO) throws Exception {
		UsrDTO usrInfo = usrDAO.getUsr(usrDTO);
		if (usrInfo == null) {
			throw new RuntimeException("아이디 혹은 비밀번호가 틀립니다.");
		}
		return usrInfo;
	}

	public int countUsrId(String usr_id) throws Exception {
		return usrDAO.countUsrId(usr_id);
		
	}

	public void regist(UsrDTO usrDTO) throws Exception{
		usrDAO.regist(usrDTO);
	}
}