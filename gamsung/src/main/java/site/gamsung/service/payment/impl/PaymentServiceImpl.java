package site.gamsung.service.payment.impl;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import site.gamsung.service.common.Search;
import site.gamsung.service.domain.Payment;
import site.gamsung.service.domain.PaymentCode;
import site.gamsung.service.domain.PointTransfer;
import site.gamsung.service.domain.SiteProfit;
import site.gamsung.service.payment.PaymentDAO;
import site.gamsung.service.payment.PaymentService;
import site.gamsung.service.user.UserDAO;



@Service("paymentServiceImpl")
public class PaymentServiceImpl implements PaymentService{
	
	///Field
	@Autowired
	@Qualifier("paymentDAOImpl")
	private PaymentDAO paymentDAO;
	
	@Autowired
	@Qualifier("userDAOImpl")
	private UserDAO userDAO;
	
	public void setPaymentDAO(PaymentDAO paymentDAO) {
		this.paymentDAO = paymentDAO;
	}
	
	
	public PaymentServiceImpl() {
		System.out.println(this.getClass());
	}
	
	
	/*
	 *  Private Method
	 */
	private String addPayment(Payment payment) throws Exception{
		
		PaymentCode oriPaymentCodeInfo = getPaymentCodeInfo(payment.getPaymentCode());
		int oriPaymentReferenceFee = oriPaymentCodeInfo.getPaymentCodeFee();
				
		// 일반결제 DB저장
		int paymentPriceTotal = payment.getPaymentPriceTotal();		
		int paymentPriceFee = paymentPriceTotal * oriPaymentReferenceFee / 100;
		int paymentPricePay = paymentPriceTotal - paymentPriceFee;
		payment.setPaymentPriceFee(paymentPriceFee);
		payment.setPaymentPricePay(paymentPricePay);
		
		System.out.println("paymentPriceTotal : " + paymentPriceTotal);										// 테스트
		System.out.println("paymentPricePay : " + paymentPricePay);	
		System.out.println("paymentPriceFee : " + paymentPriceFee);
		
		// 포인트결제 DB저장
		if(payment.getPaymentPriceTotalSecond() != 0) {
			
			int paymentPriceTotalSecond = payment.getPaymentPriceTotalSecond();		
			int paymentPriceFeeSecond = paymentPriceTotalSecond * oriPaymentReferenceFee / 100;
			int paymentPricePaySecond = paymentPriceTotalSecond - paymentPriceFeeSecond;			
			payment.setPaymentPriceFeeSecond(paymentPriceFeeSecond);
			payment.setPaymentPricePaySecond(paymentPricePaySecond);	
			
			System.out.println("paymentPriceTotalSecond : " + paymentPriceTotalSecond);						// 테스트
			System.out.println("paymentPricePaySecond : " + paymentPricePaySecond);	
			System.out.println("paymentPriceFeeSecond : " + paymentPriceFeeSecond);
		}					
		
		System.out.println("payment : " + payment);															// 테스트
		
		return paymentDAO.addPayment(payment);			
	}
		
	
	/*
	 * Point
	 */
	@Override
	public int pointUpdateById(PointTransfer pointTransfer) throws Exception {
		return paymentDAO.pointUpdateById(pointTransfer);
	}
	
	@Override
	public int pointTransferByUsers(PointTransfer pointTransfer) throws Exception {
		
		int pointAmount = pointTransfer.getPointAmount();
		int feeRate = pointTransfer.getFeeRate();		
		int adminFee = pointAmount * feeRate / 100;
		int pointAmountAfterFee = pointAmount - adminFee;
		
		if(pointTransfer.getReceiverId().equals("admin")) {
			
			PointTransfer senderCase = new PointTransfer();
			senderCase.setUserId(pointTransfer.getSenderId());
			senderCase.setPointAmount(pointAmount * -1);
			
			PointTransfer adminCase = new PointTransfer();
			adminCase.setUserId("admin");
			adminCase.setPointAmount(pointAmount);

			if(paymentDAO.pointUpdateById(senderCase) == 1 
					&& paymentDAO.pointUpdateById(adminCase) == 1 ) {
				return 1;
			} else {
				return 0;
			}
			
		} else {
			
			PointTransfer senderCase = new PointTransfer();
			senderCase.setUserId(pointTransfer.getSenderId());
			senderCase.setPointAmount(pointAmount * -1);
			
			PointTransfer receiverCase = new PointTransfer();
			receiverCase.setUserId(pointTransfer.getReceiverId());
			receiverCase.setPointAmount(pointAmountAfterFee);
			
			PointTransfer adminCase = new PointTransfer();
			adminCase.setUserId("admin");
			adminCase.setPointAmount(adminFee);				
			
			if(paymentDAO.pointUpdateById(senderCase) == 1 
					&& paymentDAO.pointUpdateById(receiverCase) == 1
					&& paymentDAO.pointUpdateById(adminCase) == 1 ) {
				return 1;
			} else {
				return 0;
			}
			
		}	
	}
	
	
	/*
	 *  Payment
	 */	
	@Override
	public String makePayment(Payment payment) throws Exception {
		
		System.out.println("addMakePayment payment : " + payment); 											// 테스트
		
		PointTransfer pointTransfer = new PointTransfer();
		Payment movePointHistory = new Payment();
		String paymentNo = "";	
		
		String oriProduct = payment.getPaymentProduct();
		String oriSenderId = payment.getPaymentSender();
		String oriReceiverId = payment.getPaymentReceiver();
		String oriPaymentCode = payment.getPaymentCode();
		PaymentCode oriPaymentCodeInfo = getPaymentCodeInfo(oriPaymentCode);
		int oriPaymentReferenceFee = oriPaymentCodeInfo.getPaymentCodeFee();
		String oriReferenceNum = payment.getPaymentReferenceNum();
		int oriPriceTotal = payment.getPaymentPriceTotal();	
		String oriMethodSecond = payment.getPaymentMethodSecond();
		int oriPriceTotalSecond = payment.getPaymentPriceTotalSecond();	
		int oriPointChargeTotal = payment.getPointChargeTotal();			
		
		if(oriPaymentCode.equals("P1")) {
			
			// 포인트이동 User_DB
			pointTransfer.setSenderId("admin");
			pointTransfer.setReceiverId(oriSenderId);		
			pointTransfer.setPointAmount(oriPointChargeTotal);	
			pointTransfer.setFeeRate(oriPaymentReferenceFee);
			pointTransferByUsers(pointTransfer);
			System.out.println("P1 포인트구매 pointTransfer : " + pointTransfer); 				// 테스트
			
			// 포인트구매내역 Payment_DB 			
			movePointHistory.setPaymentStatus(1);
			movePointHistory.setPaymentProduct(oriProduct);
			movePointHistory.setPaymentSender("[PointManageSystem-C]");
			movePointHistory.setPaymentReceiver(oriSenderId);
			movePointHistory.setPaymentCode(oriPaymentCode);
			movePointHistory.setPaymentProductPriceTotal(oriPointChargeTotal);
			movePointHistory.setPaymentMethodSecond("point");				
			movePointHistory.setPaymentPriceTotalSecond(oriPointChargeTotal);
			movePointHistory.setPaymentReferenceNum(oriReferenceNum);	
			addPayment(movePointHistory);		
			System.out.println("P1 포인트구매내역 DB저장 payment : " + movePointHistory); 			// 테스트
					
			// 결제완료내역 Payment_DB
			payment.setPaymentStatus(2);
			payment.setPaymentReceiver("[PointManageSystem-C]");
			payment.setPaymentProductPriceTotal(oriPriceTotal);			
			paymentNo = addPayment(payment);	
			System.out.println("P1 결제완료내역 저장 payment : " + payment); 						// 테스트	
			System.out.println("paymentNo : "+paymentNo);
			
			return paymentNo;
			
		} else {
			
			payment.setPaymentProductPriceTotal(oriPriceTotal);
			
			if(oriMethodSecond != null) {
				
				if(userDAO.getUser(oriSenderId).getHavingPoint() < oriPriceTotalSecond){
				
					return "ERROR_CODE_MP01-결제포인트부족";
				
				} else {
					
					// 포인트처리 User_DB	
					pointTransfer.setSenderId(oriSenderId);
					pointTransfer.setReceiverId(oriReceiverId);		
					pointTransfer.setPointAmount(oriPriceTotalSecond);	
					pointTransfer.setFeeRate(oriPaymentReferenceFee);
					pointTransferByUsers(pointTransfer);					
					payment.setPaymentProductPriceTotal(oriPriceTotal+oriPriceTotalSecond);
					
				}
			}
			
			payment.setPaymentStatus(2);	
			System.out.println("결제완료내역 저장 payment : " + payment); 						// 테스트
			paymentNo = addPayment(payment);
			System.out.println("paymentNo : "+paymentNo);
			
			return paymentNo;				
			
		}	
		
	}	
	
	@Override
	public void refundPayment(Payment payment) throws Exception {		
		paymentDAO.updateRefundPayment(payment);		
	}	
			
	@Override
	public List<Payment> listPaymentJSON(Search search) throws Exception {
		return paymentDAO.listPayment(search);	
	}	
	
	@Override
	public Payment getPaymentInfo(String paymentNo) throws Exception{
		return paymentDAO.getPaymentInfo(paymentNo);
	}
	
	@Override
	public List<Payment> getPaymentListByRsvNo(String reservationNo) throws Exception{
		return paymentDAO.getPaymentListByRsvNo(reservationNo);
	}
	
	/*
	 *  PaymentCode
	 */
	@Override
	public void addPaymentCode(PaymentCode paymentCode) throws Exception{
		paymentDAO.addPaymentCode(paymentCode);
	}
	@Override
	
	public void updatePaymentCode(PaymentCode paymentCode) throws Exception{
		paymentDAO.updatePaymentCode(paymentCode);
	}	
	
	@Override
	public List<PaymentCode> listPaymentCode() throws Exception{
		return paymentDAO.listPaymentCode();
	}
	
	@Override
	public PaymentCode getPaymentCodeInfo(String paymentCodeLetter) throws Exception{		
		return paymentDAO.getPaymentCodeInfo(paymentCodeLetter);
	}

	
	/*
	 *  SiteProfit
	 */
	@Override
	public SiteProfit listSiteProfit(String today) throws Exception{		
		return paymentDAO.listSiteProfit(today);
	}
	
	@Override
	@Scheduled(cron="0 1 0 1 * *")
	//@Scheduled(cron="5 * * * * *")
	public void calculateSiteProfit() throws Exception{	
		
		HashMap<String, Object> searchParameterPointCharge = new HashMap<String, Object>();
		HashMap<String, Object> searchParameterPayment = new HashMap<String, Object>();		
		SiteProfit oneProfitRecord = new SiteProfit();
		
		Calendar calendar = new GregorianCalendar();
		SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		
		calendar.add(Calendar.DATE, -1);		
		String payStartDay = SDF.format(calendar.getTime());	
		System.out.println("payStartDay : "+payStartDay);
		
		calendar.add(Calendar.DATE, +1);
		String payEndDay = SDF.format(calendar.getTime());
		System.out.println("payEndDay : "+payEndDay);
		
		searchParameterPointCharge.put("paymentCode", "P1");
		searchParameterPayment.put("payStartDay", payStartDay);
		searchParameterPayment.put("payEndDay", payEndDay);
		
		Payment pointChargeRecord = paymentDAO.getPaymentRecord(searchParameterPointCharge);
		Payment paymentRecord = paymentDAO.getPaymentRecord(searchParameterPayment);	
		
		System.out.println("searchParameterPointCharge : "+searchParameterPointCharge);
		System.out.println("searchParameterPayment : "+searchParameterPayment);
		System.out.println("pointChargeRecord : "+pointChargeRecord);
		System.out.println("paymentRecord : "+paymentRecord);		
		System.out.println("oneProfitRecord : "+oneProfitRecord);
		
		oneProfitRecord.setProfitPointCharge(pointChargeRecord.getPaymentPriceTotalSecond());
		oneProfitRecord.setProfitPointPayment(paymentRecord.getPaymentPriceTotalSecond());
		oneProfitRecord.setProfitRegularPayment(paymentRecord.getPaymentPriceTotal());
		oneProfitRecord.setProfitAllPayment(paymentRecord.getPaymentPriceTotalSecond()+paymentRecord.getPaymentPriceTotal());
		
		paymentDAO.addSiteProfit(oneProfitRecord);
		
	}
}
