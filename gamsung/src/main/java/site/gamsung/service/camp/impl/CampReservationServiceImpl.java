package site.gamsung.service.camp.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import site.gamsung.service.camp.CampReservationService;
import site.gamsung.service.common.Search;
import site.gamsung.service.camp.CampReservationDAO;
import site.gamsung.service.domain.Camp;
import site.gamsung.service.domain.CampReservation;
import site.gamsung.service.domain.MainSite;
import site.gamsung.service.domain.Payment;
import site.gamsung.service.domain.ReservationStatistics;
import site.gamsung.service.payment.PaymentDAO;

@Service("campReservationServiceImpl")
public class CampReservationServiceImpl implements CampReservationService {

	@Autowired
	@Qualifier("campReservationDAOImpl")
	private CampReservationDAO campReservationDAO;
	
	@Autowired
	@Qualifier("paymentDAOImpl")
	private PaymentDAO paymentDAO;
		
	public void setCampReservationDAO(CampReservationDAO campReservationDAO) {
		this.campReservationDAO = campReservationDAO;
	}

	public void setPaymentDAO(PaymentDAO paymentDAO) {
		this.paymentDAO = paymentDAO;
	}

	public CampReservationServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public List<MainSite> listPossibleReservation(Map<String, Object> map) throws Exception {
		return campReservationDAO.listPossibleReservation(map);
	}

	@Override
	public void addReservation(CampReservation campReservation) throws Exception {
		
		//insert payment(결제 정보) - insert payment(결제 정보) - 포인트, 현금, 카드 여러 형태 처리.
		campReservationDAO.addReservation(campReservation);
		campReservationDAO.updateMainSiteReservation(campReservation);
		
		Camp camp = new Camp();
		camp.setCampNo(10000);
		
		campReservationDAO.updateCampReservationCount(camp.getCampNo());
		
	}

	@Override
	public Map<String, Object> listReservation(Search search, int campNo) throws Exception {
		
		Map<String, Object> requestMap = new HashMap<String, Object>();
		requestMap.put("search", search);
		requestMap.put("campNo", campNo);
		
		List<CampReservation> list = campReservationDAO.listReservation(requestMap);
		int totalCount = campReservationDAO.getTotalCount(requestMap);
		
		Map<String, Object> responseMap = new HashMap<String, Object>();
		responseMap.put("list", list);
		responseMap.put("totalCount", totalCount);
		
		return responseMap;
	}

	@Override
	public Map<String, Object> listMyReservation(Search search, String id) throws Exception {
		
		Map<String, Object> requestMap = new HashMap<String, Object>();
		requestMap.put("search", search);
		requestMap.put("id", id);
		
		List<CampReservation> list = campReservationDAO.listReservation(requestMap);
		int totalCount = campReservationDAO.getTotalCount(requestMap);
		
		Map<String, Object> responseMap = new HashMap<String, Object>();
		responseMap.put("list", list);
		responseMap.put("totalCount", totalCount);
		
		return responseMap;
	}

	@Override
	public ReservationStatistics getReservationStatistics() throws Exception {
		return campReservationDAO.getReservationStatistics();
	}

	@Override
	public Map<String, Object> listCampReservationStatisticsByDay(Search search) throws Exception {
		
		List<ReservationStatistics> listCampReservationByDay = campReservationDAO.campReservationStatisticsByDay(search);
		int totalCampReservationCountByDay = campReservationDAO.getTotalCampReservationCountByDay(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("listCampReservationByDay", listCampReservationByDay);
		map.put("totalCampReservationCountByDay", totalCampReservationCountByDay);
		
		return map;
	}
	
	@Override
	public Map<String, Object> listCampReservationStatisticsByWeek(Search search) throws Exception {
		
		List<ReservationStatistics> listCampReservationByWeek = campReservationDAO.campReservationStatisticsByWeek(search);
		int totalCampReservationCountByWeek = campReservationDAO.getTotalCampReservationCountByWeek(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("listCampReservationByWeek", listCampReservationByWeek);
		map.put("totalCampReservationCountByWeek", totalCampReservationCountByWeek);
		
		return map;
	}
	
	@Override
	public Map<String, Object> listCampReservationStatisticsByMonth(Search search) throws Exception {
		
		List<ReservationStatistics> listCampReservationByMonth = campReservationDAO.campReservationStatisticsByMonth(search);
		int totalCampReservationCountByMonth = campReservationDAO.getTotalCampReservationCountByMonth(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("listCampReservationByMonth", listCampReservationByMonth);
		map.put("totalCampReservationCountByMonth", totalCampReservationCountByMonth);
		
		return map;
	}

	@Override
	public CampReservation getReservation(String reservationNo) throws Exception {
		return campReservationDAO.getReservation(reservationNo);
	}

	@Override
	public void updateReservation(CampReservation campReservation) throws Exception {
		
		//추가 결제 발생 시 insert payment(결제 정보) - 포인트, 현금, 카드 여러 형태 처리.
		
		CampReservation currentCampReservation = campReservationDAO.getReservation(campReservation.getReservationNo());
				
		if(currentCampReservation.getReservationStartDate() != campReservation.getReservationStartDate()
				|| currentCampReservation.getReservationEndDate() != campReservation.getReservationEndDate()
					|| currentCampReservation.getReservationUserName() != campReservation.getReservationUserName()) {
			
			if(currentCampReservation.getMainSite().getMainSiteNo() != campReservation.getMainSite().getMainSiteNo()) {
				currentCampReservation.setReservationUserName(null);
				currentCampReservation.setReservationStartDate(null);
				currentCampReservation.setReservationEndDate(null);
				campReservationDAO.updateMainSiteReservation(currentCampReservation);
				campReservationDAO.updateMainSiteReservation(campReservation);
			}else {
				campReservationDAO.updateMainSiteReservation(campReservation);
			}
		}
		campReservationDAO.updateReservation(campReservation);
		
	}

	@Override
	public void cancleReservationApply(CampReservation campReservation) throws Exception {
		
		campReservationDAO.updateReservation(campReservation);
		//get payment(예약번호) - 리스트로 받고 리스트 크기로 반복문 돌려서 결제취소 정보 입력.
		//insert payment(결제취소정보) - 예약 등록 번호별 결제 유형에 맞게 처리.
	
	}

	@Override
	public void cancleReservationDo(Payment payment) throws Exception {
	
		//예약취소 UI에서 결제 취소 진행 후 최종 확인 시 실행.
		
		CampReservation campReservation = campReservationDAO.getReservation(payment.getPaymentReferenceNum());
		campReservation.setReservationStatus(6);
		
		campReservationDAO.updateReservation(campReservation);
		
		campReservation.setReservationUserName(null);
		campReservation.setReservationStartDate(null);
		campReservation.setReservationEndDate(null);
		
		campReservationDAO.updateMainSiteReservation(campReservation);
		
	}

}
