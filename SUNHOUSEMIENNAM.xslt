<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl js" xmlns="http://www.w3.org/1999/xhtml"
xmlns:js="urn:custom-javascript" xmlns:ds="http://www.w3.org/2000/09/xmldsig#">	
	<xsl:variable name="itemsPerPage">
        <xsl:value-of select="10" />
    </xsl:variable>
	<xsl:variable name="itemCount">
		<xsl:value-of select="count(Invoice//Content//Products//Product)"/>
	</xsl:variable>
	<xsl:variable name="pagesNeeded">
        <xsl:choose>
            <xsl:when test="$itemCount &lt;= $itemsPerPage">
                <xsl:value-of select="1" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$itemCount mod $itemsPerPage = 0">
                        <xsl:value-of select="$itemCount div $itemsPerPage" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="ceiling($itemCount div $itemsPerPage)" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
	<xsl:template name="addZero">
		<xsl:param name="count"/>
		<xsl:if test="$count > 0">
			<xsl:text>0</xsl:text>
			<xsl:call-template name="addZero">
				<xsl:with-param name="count" select="$count - 1"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="congphi">
		<xsl:param name="count"/>
		<xsl:if test="$count > 0">
			<xsl:value-of select="$count">
			</xsl:value-of>
			<xsl:text>0</xsl:text>
			<xsl:call-template name="addZero">
				<xsl:with-param name="count" select="$count - 1"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="addDots">
		<xsl:param name="val"/>
		<xsl:param name="val1"/>
		<xsl:param name="val2"/>
		<xsl:param name="i" select="1"/>
		<xsl:if test="$val1>0">
			<xsl:choose>
				<xsl:when test="$val2 !=0">
					<xsl:value-of select="substring($val,$i,$val2)"/>
					<xsl:if test="substring($val,$i+$val2+1,1) !=''">
						<xsl:text>.</xsl:text>
					</xsl:if>
					<xsl:call-template name="addDots">
						<xsl:with-param name="val" select="$val"/>
						<xsl:with-param name="val1" select="$val1 - 1"/>
						<xsl:with-param name="i" select="$i + $val2"/>
						<xsl:with-param name="val2" select="3"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<!--<xsl:text>test</xsl:text>-->
					<xsl:value-of select="substring($val,$i,3)"/>
					<xsl:if test="substring($val,$i+3,1) !=''">
						<xsl:text>.</xsl:text>
					</xsl:if>
					<xsl:call-template name="addDots">
						<xsl:with-param name="val" select="$val"/>
						<xsl:with-param name="val1" select="$val1 - 1"/>
						<xsl:with-param name="i" select="$i + 3"/>
						<xsl:with-param name="val2" select="3"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<!--phan tich chuoi-->
<xsl:template name="loopExtra">
<xsl:param name="strExtra"/>
<xsl:variable name="tokenizedExtra" select="tokenize($strExtra,';')"/>
<xsl:for-each select="$tokenizedExtra">

<xsl:variable name="itemExtra" select="."/>
<xsl:if test="contains($itemExtra,'t?i')">

	<xsl:variable name="soTaiKhoan" select="substring-before($itemExtra,'t?i')"/>
	<xsl:variable name="chiNhanh" select="substring-after($itemExtra,'t?i')"/>

		<xsl:value-of select="$soTaiKhoan"/>
		<xsl:value-of select="$chiNhanh"/>
		

</xsl:if>

</xsl:for-each>

</xsl:template>
	<xsl:template name="addLine">
		<xsl:param name="count"/>
		<xsl:if test="$count > 0">
			<tr class="noline back">
				<td class="stt" height="23px">
					<xsl:value-of select="''"/>
				</td>
				<td class="back-bold" height="23px">
					<xsl:value-of select="''"/>
				</td>
				<td class="back-bold" height="23px" style="width:60px;">
					<xsl:value-of select="''"/>
				</td>
				<td class="back-bold" height="23px">
					<xsl:value-of select="''"/>
				</td>
				<td class="back-bold" height="23px" style="width:100px;">
					<xsl:value-of select="''"/>
				</td>
				<td class="back-bold" style="width:120px;">
					<xsl:value-of select="''"/>
				</td>
			</tr>
			<xsl:call-template name="addLine">
				<xsl:with-param name="count" select="$count - 1"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	 <xsl:template name="main">
        <xsl:param name="pagesNeededfnc" />
        <xsl:param name="itemCountfnc" />
        <xsl:param name="itemNeeded" />
        <xsl:for-each select="Products//Product">
            <xsl:choose>
                <!-- Vị trí dòng product đầu mỗi trang -->
                <xsl:when test=" position() mod $itemNeeded = 1">
                    <xsl:choose>
                        <!-- Dòng product đầu tiên của trang đầu -->
                        <xsl:when test="position()=1">
                            <xsl:text disable-output-escaping="yes">&lt;div class="pagecurrent" id="1"&gt;</xsl:text>
                            <xsl:text disable-output-escaping="yes">&lt;div class="statistics"&gt;</xsl:text>
                            <!--<xsl:text disable-output-escaping="yes">&lt;div style="font-size:12px;border-bottom:1px dashed #000; width:824px; float: left ; text-align: center;color:#584d77;"&gt;</xsl:text>
		Đơn vị cung cấp giải pháp hóa đơn điện tử: Tổng công ty dịch vụ viễn thông - VNPT Vinaphone, MST:0106869738, Điện thoại:18001260
				<xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>-->
                            <xsl:text disable-output-escaping="yes">&lt;div class="nenhd" style="margin-bottom: 10px!important;"&gt;</xsl:text>
                            
                            <xsl:text disable-output-escaping="yes">&lt;table width="100%" cellspacing="0" cellpadding="0" style="width:810px !important;border-bottom: 1px solid !important;"&gt;</xsl:text>
                             <xsl:text disable-output-escaping="yes">&lt;thead&gt;</xsl:text>
                             <xsl:text disable-output-escaping="yes">&lt;tr style=""&gt;</xsl:text>
							<xsl:text disable-output-escaping="yes">&lt;td colspan="6" style="padding-left: 0px!important;padding-right: 0px!important;"&gt;</xsl:text>
                            <xsl:call-template name="addfirtbody">
                            </xsl:call-template>
                            <xsl:call-template name="addsecondbody">
                            </xsl:call-template>
                          
                            <xsl:text disable-output-escaping="yes">&lt;/td&gt;</xsl:text>
							<xsl:text disable-output-escaping="yes">&lt;/tr&gt;</xsl:text>
                            <xsl:text disable-output-escaping="yes">&lt;/thead&gt;</xsl:text>
                           <xsl:text disable-output-escaping="yes">&lt;tbody class="nenhd" style=""&gt;</xsl:text>
                           
                            <xsl:call-template name="calltitleproduct">
                            
                            </xsl:call-template>
                            
                            <xsl:call-template name="callbodyproduct">
                            
                            
                            
                            </xsl:call-template>
                          
                            <!-- Trường hợp chỉ có 1 sản phẩm product -->
                            <xsl:if test="(position()=1) and $itemCountfnc=1">
                                <xsl:call-template name="addLine">
                                    <xsl:with-param name="count" select="$pagesNeededfnc * $itemNeeded - $itemCountfnc" />
                                </xsl:call-template>
                                <xsl:call-template name="calltongsoproduct">
                                </xsl:call-template>
                               <!-- <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>-->
                                <xsl:call-template name="addfinalbody">
                                </xsl:call-template>
                              
                                <xsl:call-template name="addchuky">
                                </xsl:call-template>
                              
                                <xsl:text disable-output-escaping="yes">&lt;/tbody&gt;</xsl:text>
                                
                                <xsl:text disable-output-escaping="yes">&lt;/table&gt;</xsl:text>
                                <xsl:text disable-output-escaping="yes">&lt;div class="nenhd_bg" style="margin-top: -6px; margin-left: -26px"&gt;&lt;/div&gt;</xsl:text>
                                <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                                <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                                <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                            </xsl:if>
                        </xsl:when>
                        <!-- Dòng product đầu của các trang sau -->
                        <xsl:otherwise>
                            <xsl:text disable-output-escaping="yes">&lt;div class="pagecurrent" id=</xsl:text>
                            <xsl:value-of select="((position()-1) div $itemNeeded) + 1" />
                            <xsl:text disable-output-escaping="yes">&gt;</xsl:text>
                            <xsl:text disable-output-escaping="yes">&lt;div class="statistics"&gt;</xsl:text>
                            <!--<xsl:text disable-output-escaping="yes">&lt;div style="font-size:12px;border-bottom:1px dashed #584d77; width:824px; float: left ;text-align: center;color:#584d77;"&gt;</xsl:text>
		Đơn vị cung cấp giải pháp hóa đơn điện tử: Tổng công ty dịch vụ viễn thông - VNPT Vinaphone, MST:0106869738, Điện thoại:18001260
				<xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>-->
                            <xsl:text disable-output-escaping="yes">&lt;div class="nenhd" style="margin-bottom: 0px !important;"&gt;</xsl:text>
                            <xsl:text disable-output-escaping="yes">&lt;table width="100%" cellspacing="0" cellpadding="0" style="width:810px !important;border_bottom:1px solid !important; "&gt;</xsl:text>
                            
                             <xsl:text disable-output-escaping="yes">&lt;thead&gt;</xsl:text>
                             <xsl:text disable-output-escaping="yes">&lt;tr style=""&gt;</xsl:text>
							<xsl:text disable-output-escaping="yes">&lt;td colspan="6" style="padding-left: 0px!important;padding-right: 0px!important;"&gt;</xsl:text>
                          <!--<xsl:call-template name="addtitlenextbody">
                            </xsl:call-template>-->
                            <xsl:call-template name="addfirtbody">
                            </xsl:call-template>
                            <!--<xsl:call-template name="addsecondbody">
                            </xsl:call-template>-->
                            
                            
                            <!-- Phân trang -->
                            <table>																				
									<tr>
										<td colspan="6">
												  <div style="margin-left: 318px; margin-top: 8px; height:20px">
														<label>Tiếp theo trang trước - trang </label>
														<xsl:value-of select="((position()-1) div $itemNeeded) + 1" />/<xsl:value-of select="$pagesNeededfnc" />
													</div>																			
										</td>
									</tr>																				
							</table>
							<!-- 
                             <xsl:call-template name="addsecondbody">
                            </xsl:call-template>
                            -->
							
                            <xsl:text disable-output-escaping="yes">&lt;/td&gt;</xsl:text>
							<xsl:text disable-output-escaping="yes">&lt;/tr&gt;</xsl:text>
                            <xsl:text disable-output-escaping="yes">&lt;/thead&gt;</xsl:text>
                           <xsl:text disable-output-escaping="yes">&lt;tbody class="nenhd" style=""&gt;</xsl:text>
                           
                            <xsl:call-template name="calltitleproduct">
                            </xsl:call-template>
                            <xsl:call-template name="callbodyproduct">
                            </xsl:call-template>
                            
                            <!-- Trường hợp dòng product cuối cùng là dòng đầu tiên của trang cuối cùng -->
                            <xsl:if test=" position() = $itemCountfnc">
                                <xsl:call-template name="addLine">
                                    <xsl:with-param name="count" select="$pagesNeededfnc * $itemNeeded - $itemCountfnc" />
                                </xsl:call-template>
                                <xsl:call-template name="calltongsoproduct">
                                </xsl:call-template>
                                <xsl:call-template name="addfinalbody">
                                </xsl:call-template>
                                <xsl:text disable-output-escaping="yes">&lt;/table&gt;</xsl:text>
                                <xsl:call-template name="addchuky">
                                </xsl:call-template>
                              
                                <xsl:text disable-output-escaping="yes">&lt;/tbody&gt;</xsl:text>
                                
                                <xsl:text disable-output-escaping="yes">&lt;/table&gt;</xsl:text>
                                <xsl:text disable-output-escaping="yes">&lt;div class="nenhd_bg" style="margin-top: -6px; margin-left: -26px"&gt;&lt;/div&gt;</xsl:text>
                                <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                                <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                                <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:when>
                <!-- Vị trí dòng product cuối cùng mỗi trang, không phải trang cuối -->
                <xsl:when test=" (position() mod $itemNeeded = 0) and (position() &lt; $itemCountfnc)">
                    <xsl:call-template name="callbodyproduct">
                    </xsl:call-template>
                    <xsl:text disable-output-escaping="yes">&lt;/tbody&gt;</xsl:text>                                
					<xsl:text disable-output-escaping="yes">&lt;/table&gt;</xsl:text>
					<xsl:text disable-output-escaping="yes">&lt;div class="nenhd_bg" style="margin-top: -6px; margin-left: -26px"&gt;&lt;/div&gt;</xsl:text>
					<xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
					<xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
					<xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                    <p style='page-break-before: always' />
                </xsl:when>
                <!-- Vị trí dòng sản phẩm cuối cùng -->
                <xsl:when test=" position() = $itemCountfnc">
                    <xsl:call-template name="callbodyproduct">
                    </xsl:call-template>
                    <xsl:call-template name="addLine">
                        <xsl:with-param name="count" select="$pagesNeededfnc * $itemNeeded - $itemCountfnc" />
                    </xsl:call-template>
                    <xsl:call-template name="calltongsoproduct">
                    </xsl:call-template>                    
                    <xsl:call-template name="addfinalbody">
                    </xsl:call-template>
                    <xsl:call-template name="addchuky">
                    </xsl:call-template>
                    <xsl:text disable-output-escaping="yes">&lt;/tbody&gt;</xsl:text>                                
					<xsl:text disable-output-escaping="yes">&lt;/table&gt;</xsl:text>
					<xsl:text disable-output-escaping="yes">&lt;div class="nenhd_bg" style="margin-top: -6px; margin-left: -26px"&gt;&lt;/div&gt;</xsl:text>
					<xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
					<xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
					<xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                </xsl:when>
                <!-- Các vị trí dòng sản phẩm ở khoảng giữa một trang -->
                <xsl:otherwise>
                    <xsl:call-template name="callbodyproduct">
                    </xsl:call-template>
                </xsl:otherwise>

            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="addtitlenextbody">
		 <table cellspacing="0" cellpadding="0" border="none" style="width:810px!important">
       
			<tr style="">  <!-- border-bottom: 2px solid #584d77 -->
			    <td colspan="6">
					<table>
						<tbody>
              <tr>
                <td colspan="6" style="border: none;">
                  <div id="logo"/>
                </td>
              </tr>
              <tr>

                <td colspan="6" style="text-align:center;border:none;">

                  <b style="font-size:16px;">
                    <xsl:value-of select="../../ComName"/>
                  </b>

                </td>
              </tr>
              <tr>
                <td colspan="6" style="text-align:center;border:none;">

                  Trụ sở chính:  <xsl:value-of select="../../ComAddress"/>

                </td>
              </tr>
              <tr>

                <td colspan="6" style="text-align:center;border:none;">
                  <i>Head Office: 2D2-12 Sky Garden, Phu My Hung, Tan Phong Ward, District 7, Ho Chi Minh City, Viet Nam </i>
                </td>
              </tr>
              <tr>
                <td colspan="6" style="text-align:center;border:none;">
                  VP giao dịch: 151 Thành Mỹ, Phường 8, Quận Tân Bình, TP.HCM
                </td>
              </tr>
              <tr style="border-bottom:1px solid;">
                <td colspan="6" style="text-align:center;border:none;">
                  <i>Transaction Office: 151 Thanh My Street, Ward 8, Tan Binh District, Ho Chi Minh City, Viet Nam</i>
                </td>
              </tr>
							
             
						</tbody>
					</table>
			    </td>
				
			</tr>
		</table>
    </xsl:template>
    <xsl:template name="addfirtbody">
		 <table cellspacing="0" cellpadding="0" border="none" style="width:810px!important">
       <!--<tr>
	   <td colspan="6" style="text-align:center; border-right: none!important; border-left: none!important">
	  <xsl:value-of select="../../isReplace"/>
		 <xsl:value-of select="../../isAdjust"/>
		 <xsl:choose>
		   <xsl:when test="/Invoice/convert!=''">
			 <div style="text-align:center;margin-bottom:30px;">
			   <div>
				 <label style="font-size:10px">
				   <b>
					 HÓA ĐƠN CHUYỂN ĐỔI TỪ HÓA ĐƠN ĐIỆN TỬ
				   </b>
				 </label>
				 <p style="font-size:10px; margin:0px">
				   Ngày <b style="color:#584C56">
					 <xsl:value-of select="substring(/Invoice/ConvertDate,1,2)"/>
				   </b> tháng <b style="color:#584C56">
					 <xsl:value-of select="substring(/Invoice/ConvertDate,4,2)"/>
				   </b> năm <b style="color:#584C56">

					 <xsl:value-of select="concat('20',substring(/Invoice/ConvertDate,9,2))"/>
				   </b>
				 </p>
				 <p style="font-size:10px; margin:0px">
				   Người chuyển đổi
				 </p>
				 <i style="font-size:10px; margin:0px">
				   ( Signature of converter )
				 </i>
				 --><!--<p style="margin-top:60px">
				  <xsl:value-of select="../../ConvertBy"/>
				</p>--><!--
				 --><!--<p style="font-size:14px; margin:0px">
				  Thủ trưởng đơn vị
				</p>--><!--
			   </div>
			 </div>
		  </xsl:when>
   </xsl:choose>
	   </td>

	 </tr>-->
			<tr style="">  <!-- border-bottom: 2px solid #584d77 -->
			    <td colspan="6">
					<table>
						<tbody>
              <tr>
                <td colspan="6" style="border: none;">
                  <div id="logo"/>
                </td>
              </tr>
              <tr>

                <td colspan="6" style="text-align:center;border:none;">

                  <b style="font-size:16px;">
                    <xsl:value-of select="../../ComName"/>
                  </b>

                </td>
              </tr>


              <tr>
                <td colspan="6" style="text-align:center;border:none;">

                  Trụ sở chính:  <xsl:value-of select="../../ComAddress"/>

                </td>
              </tr>
              <tr>

                <td colspan="6" style="text-align:center;border:none;">
                  <i>Head Office: 2D2-12 Sky Garden, Phu My Hung, Tan Phong Ward, District 7, Ho Chi Minh City, Viet Nam </i>
                </td>
              </tr>
              <tr>
                <td colspan="6" style="text-align:center;border:none;">
					 VP giao dịch: 151 Thành Mỹ, Phường 8, Quận Tân Bình, TP.HCM
                </td>
              </tr>
              <tr style="border-bottom:1px solid;">
                <td colspan="6" style="text-align:center;border:none;">
                  <i>Transaction Office: 151 Thanh My Street, Ward 8, Tan Binh District, Ho Chi Minh City, Viet Nam</i>
                </td>
              </tr>
							<!--<tr>
									 <td width="75px" valign="top" style=" border-left: none!important;border-right: none!important;border-bottom: none!important;">
										 <div id="" style="width: 70px;"/>
									 </td>
							        <td width="250px" style=" border-left: none!important;border-right: none!important;border-bottom: none!important;">
                                            <table style="text-align:center">
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <span style="font-size:13px; color:#EB363A; font-weight:bold">
																	<xsl:value-of select="../../ComName"/> 
                                                            </span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="font-size:12px">
                                                            Địa chỉ: <xsl:value-of select="../../ComAddress"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="font-size:12px">
                                                         ĐT: <xsl:value-of select="../../ComPhone"/> - Fax: <xsl:value-of select="../../ComPhone"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="font-size:12px">
                                                           <b>MST: <xsl:value-of select="../../ComTaxCode" /></b> 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table>
                                                                <tbody></tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
								
									<td width="325px" valign="top" style=" border-left: none!important;border-right: none!important;border-bottom: none!important; text-align: center">
															 <p style="margin:0px; font-size:18px; font-weight:bold">
                                                              HÓA ĐƠN BÁN HÀNG
                                                            </p>
                                                            <p style="font-size:12px; height:30px">
                                                                <xsl:choose>
                                                                    <xsl:when test="substring(ArisingDate,7,4)!= '1957' and substring(../../ArisingDate,7,4)!= ''">
                                                                        Ngày &#160;
                                                                        <label style="border-bottom: 1px dotted #000000  !important; color:#000000; font-weight:bold">
                                                                            <xsl:value-of select="substring(../../ArisingDate,1,2)" />
                                                                        </label>
                                                                        &#160; tháng &#160;
                                                                        <label style="border-bottom: 1px dotted #000000 !important; color:#000000; font-weight:bold">
                                                                            <xsl:value-of select="substring(../../ArisingDate,4,2)" />
                                                                        </label>
                                                                        &#160; năm &#160;
                                                                        <label style="border-bottom: 1px dotted #000000; color:#000000; font-weight:bold">
                                                                            --><!--<xsl:value-of select="substring(ArisingDate,9,2)"/>--><!--
                                                                            <xsl:value-of select="concat('20',substring(../../ArisingDate,9,2))" />
                                                                        </label>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        Ngày <label style="border-bottom: 1px dotted #000000;">&#160;&#160;&#160;&#160;</label> tháng <label style="border-bottom: 1px dotted #000000;">&#160;&#160;&#160;&#160;</label> năm <label style="border-bottom: 1px dotted #000000;">&#160;&#160;&#160;&#160;</label>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                            </p>																					
									</td>
									 <td width="165px" valign="top">
                                            <table border="0">
                                                    <tr>
                                                        <td style="font-size:14px">
                                                            --><!--<p>--><!--
                                                                Mẫu số: <b><xsl:value-of select="../../InvoicePattern" /></b>
                                                                <br />
                                                                Ký hiệu:
                                                                <b>
                                                                    <xsl:value-of select="../../SerialNo" />
                                                                </b>
                                                                <br />
                                                            <p style="padding:0px; margin-top:5px; font-size:14px">
                                                                Số:
                                                                <b>
																	<span class="number" style="color:#EB363A; font-size:20px; padding-left:5px">
																		<xsl:call-template name="addZero">
																			<xsl:with-param name="count" select="7-string-length(../../InvoiceNo)" />
																		</xsl:call-template>
																		<xsl:value-of select="../../InvoiceNo" />
																	</span>
                                                                </b>
                                                            </p>
                                                        </td>
                                                    </tr>
                                            </table>
                                        </td>
							</tr>-->
              <tr>
                <td colspan="4" style="width:513px; border-left: none!important;border-right: none!important;border-bottom: none!important;">
                  <table cellspacing="0" cellpadding="0"  style="width:500px!important;float: left;">
                    <tr>
                      <td colspan="1" style=" width: 175px;border-left: none!important;    border-right: none !important;">
                        <div class="fl-l2">
                          <label class="fl-l" style="width:175px">
                            Mã số thuế <i>(VAT code)</i>:
                          </label>
                        </div>
                      </td>
                      <td colspan="1" style=" border-left: none!important;    border-right: none !important;">
                        <div class="fl-l2">
                          <label class="input-code" maxlength="1" style="margin-right:0px; height:18px">
                            <xsl:value-of select="substring(../../ComTaxCode,1,1)"/>
                          </label>
                          <label class="input-code" style="margin-right:5px;border-left:0px; height:18px" maxlength="1">
                            <xsl:value-of select="substring(../../ComTaxCode,2,1)"/>
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px; height:18px">
                            <xsl:value-of select="substring(../../ComTaxCode,3,1)"/>
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px;border-left:0px; height:18px">
                            <xsl:value-of select="substring(../../ComTaxCode,4,1)"/>
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px;border-left:0px; height:18px">
                            <xsl:value-of select="substring(../../ComTaxCode,5,1)"/>
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px;border-left:0px; height:18px">
                            <xsl:value-of select="substring(../../ComTaxCode,6,1)"/>
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px;border-left:0px; height:18px">
                            <xsl:value-of select="substring(../../ComTaxCode,7,1)"/>
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px;border-left:0px; height:18px">
                            <xsl:value-of select="substring(../../ComTaxCode,8,1)"/>
                          </label>
                          <label class="input-code" style="margin-right:5px;border-left:0px; height:18px" maxlength="1">
                            <xsl:value-of select="substring(../../ComTaxCode,9,1)"/>
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:5px; height:18px">
                            <xsl:value-of select="substring(../../ComTaxCode,10,1)"/>
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px; height:18px">
                            <xsl:value-of select="substring(../../ComTaxCode,11,1)"/>
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px;border-left:0px; height:18px">
                            <xsl:value-of select="substring(../../ComTaxCode,12,1)"/>
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:5px;border-left:0px; height:18px">
                            <xsl:value-of select="substring(../../ComTaxCode,13,1)"/>
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px; height:18px">
                            <xsl:value-of select="substring(../../ComTaxCode,14,1)"/>
                          </label>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="6" style=" border-left: none!important;border-right: none!important;">
                        <div class="clearfix">
                          <label class="fl-l2" style="width:513px; font-weight:bold;">
                            Tên khách hàng và địa chỉ (Customer's name &amp; Address):
                          </label>
                          <div class="" style="width:465px;height:90px; float:left;border:1px solid;display:inline-table;">
                            <!--ghi chu-->
                          <label class="" style="width: 513px;padding-left:10px;display:inline-block;">
                            <i>
                              
                              <xsl:choose>
                                <xsl:when test="../../Extra!=''">
                                  (
                                  <xsl:value-of select="../../Extra"/>
                                 )
                                </xsl:when>
                                <xsl:otherwise>
                                  &#160;
                                </xsl:otherwise>
                              </xsl:choose>
                             
                            </i>
                            </label><br/>
                            <label class="" style="width:513px;padding-left:10px;display:inline-block;">
                              <b>
                                <!--<xsl:choose>
                                  <xsl:when test="../../Buyer!=''">
                                    <xsl:value-of select="../../Buyer"/> -
                                  </xsl:when>

                                  <xsl:otherwise>
                                    &#160;
                                  </xsl:otherwise>
                                </xsl:choose>-->
                                <xsl:choose>

                                  <xsl:when test="../../CusName!=''">
                                    <xsl:value-of select="../../CusName"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    &#160;
                                  </xsl:otherwise>
                                </xsl:choose>
                              </b>
                            </label>
                            <!--diachi-->
                            <br/>
                            <label class="" style="width: 513px;padding-left:10px;display:inline-block;">
                              <xsl:choose>
                                <xsl:when test="../../CusAddress!=''">
                                  <xsl:value-of select="../../CusAddress"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  &#160;
                                </xsl:otherwise>
                              </xsl:choose>
                            </label>
                            <br/>
							  <label class="fl-l" style="width: 300px;padding-left:10px;">
								Mã số thuế:
								<xsl:choose>
                                <xsl:when test="../../CusTaxCode!=''">
                                  <xsl:value-of select="../../CusTaxCode"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  &#160;
                                </xsl:otherwise>
                              </xsl:choose>
							  </label>
                          </div>
                        </div>
                      </td>
                    </tr>
                    <!--<tr>
                      <td colspan="6" style=" border-left: none!important;border-right: none!important;">
                        <div class="clearfix">
                          <label class="fl-l2" style="width:267px">
                            Địa chỉ<i>(Address)</i>:
                          </label>
                          <label class="fl-l input-name" style="width: 513px;">
                            <xsl:choose>
                              <xsl:when test="CusAddress!=''">
                                <xsl:value-of select="CusAddress"/>
                              </xsl:when>
                              <xsl:otherwise>
                                &#160;
                              </xsl:otherwise>
                            </xsl:choose>
                          </label>
                        </div>
                      </td>
                    </tr>-->

                    <tr>
                      <td colspan="6" style=" border-left: none!important;border-right: none!important;">
                        <div class="fl-l2">
							<label class="fl-l" style="width: 467px;font-weight:bold;">
								Địa chỉ giao hàng:
								<xsl:choose>
                                <xsl:when test="../../Extras/Extra_item[Extra_Name='Extra_DiaChiGiaoHang']/Extra_Value!=''">
                                  <xsl:value-of select="../../Extras/Extra_item[Extra_Name='Extra_DiaChiGiaoHang']/Extra_Value"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  &#160;
                                </xsl:otherwise>
                              </xsl:choose>
							  </label>
                        </div>
                        <!--<div class="fl-l2" style="">
                          <label class="input-code" maxlength="1" style="margin-right:0px; height:14px">
                            <xsl:value-of select="substring(../../CusTaxCode,1,1)" />
                          </label>
                          <label class="input-code" style="margin-right:5px;border-left:0px; height:14px" maxlength="1">
                            <xsl:value-of select="substring(../../CusTaxCode,2,1)" />
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px; height:14px">
                            <xsl:value-of select="substring(../../CusTaxCode,3,1)" />
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px;border-left:0px; height:14px">
                            <xsl:value-of select="substring(../../CusTaxCode,4,1)" />
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px;border-left:0px; height:14px">
                            <xsl:value-of select="substring(../../CusTaxCode,5,1)" />
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px;border-left:0px; height:14px">
                            <xsl:value-of select="substring(../../CusTaxCode,6,1)" />
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px;border-left:0px; height:14px">
                            <xsl:value-of select="substring(../../CusTaxCode,7,1)" />
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px;border-left:0px; height:14px">
                            <xsl:value-of select="substring(../../CusTaxCode,8,1)" />
                          </label>
                          <label class="input-code" style="margin-right:5px;border-left:0px; height:14px" maxlength="1">
                            <xsl:value-of select="substring(../../CusTaxCode,9,1)" />
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:5px; height:14px">
                            <xsl:value-of select="substring(../../CusTaxCode,10,1)" />
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px; height:14px">
                            <xsl:choose>
                              --><!--<xsl:when test="substring(CusTaxCode,10)  = ''"></xsl:when>--><!--
                              <xsl:when test="string-length(../../CusTaxCode)  &gt; 11">
                                -
                              </xsl:when>
                              <xsl:otherwise>
                                 
                              </xsl:otherwise>
                            </xsl:choose>
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px;border-left:0px; height:14px">
                            <xsl:value-of select="substring(../../CusTaxCode,12,1)" />
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:5px;border-left:0px; height:14px">
                            <xsl:value-of select="substring(../../CusTaxCode,13,1)" />
                          </label>
                          <label class="input-code" maxlength="1" style="margin-right:0px; height:14px">
                            <xsl:value-of select="substring(../../CusTaxCode,14,1)" />
                          </label>
                        </div>-->
                      </td>
                    </tr>

                    <tr>
                      <td colspan="6" style=" border-left: none!important;border-right: none!important;">
                        <div class="fl-l2">
                          <label class="fl-l2" style="width:250px;font-weight:bold;">
                            Phương thức thanh toán<i>(Payment method)</i>:
                          </label>
                          <xsl:choose>
                            <xsl:when test="../../Kind_of_Payment!=''">
                              <label class="" style="width:240px;">

                                <xsl:choose>
                                  <xsl:when test="../../Kind_of_Payment ='TM'">
                                    TM
                                  </xsl:when>
                                  <xsl:when test="../../Kind_of_Payment ='CK'">
                                    CK
                                  </xsl:when>
                                  <xsl:when test="../../Kind_of_Payment ='TTD'">
                                    TTD
                                  </xsl:when>
                                  <xsl:when test="../../Kind_of_Payment ='HDDT'">
                                    HDDT
                                  </xsl:when>
                                  <xsl:when test="../../Kind_of_Payment ='TM, CK'">
                                    TM/CK
                                  </xsl:when>
                                  <xsl:when test="../../Kind_of_Payment ='Bù trừ'">
                                    Bù trừ
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <label class="" style="width:240px;">

                                    </label>
                                  </xsl:otherwise>
                                </xsl:choose>

                              </label>
                            </xsl:when>
                            <xsl:otherwise>
                              <label class="" style="width:240px;">


                              </label>
                            </xsl:otherwise>
                          </xsl:choose>
                        </div>
                        
                      </td>
                    </tr>

                  </table>
                </td>

                <td colspan="2" style=" border-left: none!important;border-right: none!important;border-bottom: none!important;">
                  <div style="margin-top: 10px;margin-left:10px; float: left; text-align: left;">
                    <div>
                      <div>
                        <p class="name-upcase" style="border:1px solid; background-color:rgb(195,195,195);font-weight: bold;text-align:center;color:black;line-height: 26px; margin-top: 0px; margin-bottom: 0px;font-size:23px; text-transform: uppercase;">
                          HÓA ĐƠN (GTGT) <br/>
                          <i style="margin:0 auto; left:-50%;">INVOICE (VAT)</i><br/>
		 <xsl:choose>
		   <xsl:when test="/Invoice/convert!=''">

				 <label style="font-size:16px">
				   <b style="color:#584C56">
					 HÓA ĐƠN CHUYỂN ĐỔI TỪ HÓA ĐƠN ĐIỆN TỬ
           
				   </b>
         
				 </label>
				 

		  </xsl:when>
   </xsl:choose>
	   
                        </p>
                        <p style="color: black !important;">
                          Mẫu số <i>(Form)</i>:<span style="font-weight: bold!important;font-size: 16px!important;">
                            &#160;<xsl:value-of select="../../InvoicePattern"/>
                          </span>
                        </p>
                        <p style="color: black !important;">
                          Ký hiệu <i>(Series)</i>:<span style="font-weight: bold!important;font-size: 16px!important;">
                            &#160;<xsl:value-of select="../../SerialNo"/>
                          </span>
                        </p>
                        <p style="color: black !important;">
                          Số <i>(No)</i>:
                          <span style="font-weight: bold!important;color:red!important;font-size: 20px!important;">
                            <xsl:call-template name="addZero">
                              <xsl:with-param name="count" select="7-string-length(../../InvoiceNo)"/>
                            </xsl:call-template>
                            <xsl:value-of select="../../InvoiceNo"/>
                          </span>
                        </p>
                        Ngày <i>(Date)</i>:
                        <xsl:choose>
                          <xsl:when test="substring(../../ArisingDate,7,4)!= '1957' and substring(../../ArisingDate,7,4)!= ''">
                            &#160;
                            <label style="border-bottom: 0px dotted #000000; color:#000000">
                              <b>
                                <xsl:value-of select="substring(../../ArisingDate,1,2)"/>
                              </b>
                            </label>
                            &#160; /&#160;
                            <label style="border-bottom: 0px dotted #000000; color:#000000">
                              <b>
                                <xsl:value-of select="substring(../../ArisingDate,4,2)"/>
                              </b>
                            </label>
                            &#160; /&#160;
                            <label style="border-bottom: 0px dotted #000000; color:#000000">
                              <!--<xsl:value-of select="substring(ArisingDate,9,2)"/>-->
                              <b>
                                <xsl:value-of select="concat('20',substring(../../ArisingDate,9,2))"/>
                              </b>
                            </label>
                          </xsl:when>
                          <xsl:otherwise>
                            <!--Ngày<label style="border-bottom: 1px dotted #000000;">&#160;&#160;&#160;&#160;</label> tháng <label style="border-bottom: 1px dotted #000000;">&#160;&#160;&#160;&#160;</label> năm <label style="border-bottom: 1px dotted #000000;">&#160;&#160;&#160;&#160;</label>-->
                          </xsl:otherwise>
                        </xsl:choose>
                        

                      </div>



                    </div>
                  </div>

                </td>
              </tr>
						</tbody>
					</table>
			    </td>
				
			</tr>
		</table>
    </xsl:template>
    <xsl:template name="addsecondbody">
        <table cellspacing="0" cellpadding="0" border="none" style="width:810px!important;float: left;">
																<tr>
                                        <td colspan="1" style="width:95px;border-left:none;border-right:none;">
                                          <label style="width:100px;font-weight:bold;">
                                            Đơn đặt hàng số:
                                            <br/><i>(Customer order No)</i>
                                          </label>
                                        </td>
                                        <td colspan="1" style="width:100px; border-left:none;border-right:none;">
                                          <label style="float:left;">
                                            <xsl:choose>
                                              <xsl:when test="../../Extras/Extra_item[Extra_Name='Extra_DonDatHangSo']/Extra_Value!=''">
                                                <xsl:value-of select="../../Extras/Extra_item[Extra_Name='Extra_DonDatHangSo']/Extra_Value"/>
                                              </xsl:when>
                                              <xsl:otherwise>

                                              </xsl:otherwise>
                                            </xsl:choose>

                                          </label>
                                        </td>
                                        <td colspan="1" style="width:95px;border-left:none;border-right:none;">
                                          <label style="width:100px;font-weight:bold;">
                                            Đơn hàng bán số: 
                                            <br/><i>(Sales order No)</i>
                                          </label>
                                        </td>
                                        <td colspan="1" style="width:100px; border-left:none;border-right:none;">
                                          <label style="float:left;">
                                            <xsl:choose>
                                              <xsl:when test="../../Extras/Extra_item[Extra_Name='Extra_DonHangBanSo']/Extra_Value!=''">
                                                <xsl:value-of select="../../Extras/Extra_item[Extra_Name='Extra_DonHangBanSo']/Extra_Value"/>
                                              </xsl:when>
                                              <xsl:otherwise>

                                              </xsl:otherwise>
                                            </xsl:choose>

                                          </label>
                                        </td>
                                        <td colspan="1" style="width:150px;border-left:none;border-right:none;">
                                          <label style="font-weight:bold; width:100px;">
                                            ĐVT (Currency): VNĐ
                                          </label>
                                        </td>
                                        <!--<td colspan="1" style="width:100px; border-left:none;border-right:none;">
                                          <label style="float:left;">
                                            VNĐ
                                            --><!--<xsl:choose>
                                              <xsl:when test="Extra3!=''">
                                                <xsl:value-of select="Extra3"/>
                                              </xsl:when>
                                              <xsl:otherwise>

                                              </xsl:otherwise>
                                            </xsl:choose>--><!--

                                          </label>
                                        </td>-->
                                      </tr>
        
															</table>
    </xsl:template>
    <xsl:template name="calltitleproduct">
    <tr style="height: 30px;">
		<th>
			STT
		</th>
		<th>
			Diễn giải
		</th>
      <th style="width:60px;">
        Đơn vị tính
      </th>
		<th>
			Số lượng
		</th>
		<th style="width:100px;">
			Đơn giá
		</th>
		<th style="width:120px;">
			Thành tiền
		</th>
	</tr>
	<tr style="">
		<th class="h2">
			1
		</th>
		<th class="h2">
			2
		</th>
    <th class="h2" style="width:60px;">
      3
    </th>
		<th class="h2">
			4
		</th>
		<th class="h2" style="width:100px;">
			5
		</th>
		<th class="h2" style="width:120px;">
			6=4x5
		</th>
	</tr>
    </xsl:template>
    <xsl:template name="callbodyproduct">
		<tr class="noline back;">
			<td class="stt">
			  <div style="display: block;width: 40px;color:#0f2fa8;">
				 <xsl:value-of select="position()"/>
				</div>
			</td>
			<td class="back-bold">
			  <div style="color:#0f2fa8;display: block;word-wrap: break-word;width: 380px;text-align: left;  overflow: hidden; padding-left:5px">
        <xsl:choose>
					<xsl:when test="(ProdPrice=0) and (Amount = 0) ">
            <div style="width:380px;">
              <xsl:value-of select="ProdName"/>
            </div>
            (Khuyến mại không thu tiền)
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="ProdName"/>
					</xsl:otherwise>
				</xsl:choose>   
        
			 
			</div>
			</td>
			<td class="back-bold">
			 <div style="color:#0f2fa8;display: block;word-wrap: break-word;width: 60px;text-align: left;  overflow: hidden;padding-left:5px">
				 <xsl:value-of select="ProdUnit"/>
				 </div>
			</td>
			<td class="back-bold">
			 <div style="color:#0f2fa8;display: block;word-wrap: break-word;width: 70px;text-align: center;  overflow: hidden;">
				 <xsl:choose>
					<xsl:when test="(ProdQuantity='') or(ProdQuantity=0)">
&#160;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="translate(translate(translate(format-number(ProdQuantity, '###,###'),',','?'),'.',','),'?','.')"/>
					</xsl:otherwise>
				</xsl:choose> 
				</div>
			</td>
			<td class="back-bold">
			 <div style="color:#0f2fa8;display: block;word-wrap: break-word;width: 100px;text-align: right;  overflow: hidden;">
				 <xsl:choose>
					<xsl:when test="(ProdPrice='') or(ProdPrice=0)">
&#160;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="translate(translate(translate(format-number(ProdPrice, '###,###'),',','?'),'.',','),'?','.')"/>
					</xsl:otherwise>
				</xsl:choose> 
				</div>
			</td>
			<td class="back-bold">
			 <div style="color:#0f2fa8;display: block;word-wrap: break-word;width: 120px;text-align: right; overflow: hidden;">
				<xsl:choose>
					<xsl:when test="(Amount=0) or(Amount='')">
&#160;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="translate(translate(translate(format-number(Amount, '###,###'),',','?'),'.',','),'?','.')"/>
					</xsl:otherwise>
				</xsl:choose>
				</div>
			</td>
		</tr>
    </xsl:template>
    <xsl:template name="calltongsoproduct">
    
       <tr  class="noline back" style="border-top: 1px solid #000;border-bottom: 1px solid #000;">
			<td class="back-bold" colspan="5" style="padding-left: 0px;text-align: left !important;">
			<div class="clearfix" style="text-align: right; padding-left:8px">
					<label class="fl-l" style="float:right;">Cộng tiền hàng <i>(Balance due)</i>:</label>
				</div>
			</td>
			<td>
			 <div style="display: block;word-wrap: break-word;width: 120px;text-align: right;padding-left:1px;  overflow: hidden; font-weight: bold">
			
						<xsl:choose>
							<xsl:when test="../../Total!=''">
								&#160;  <xsl:value-of select="translate(translate(translate(format-number(../../Total, '###,###'),',','?'),'.',','),'?','.')"/> 
							</xsl:when> 
							<xsl:otherwise>
								&#160;
							</xsl:otherwise>
						</xsl:choose>
				</div>
			</td>
	</tr>	
	
    </xsl:template>
    
    <xsl:template name="addfinalbody">
    <!-- Tổng cộng tiền -->
    <!--
    <tr  class="noline back" style="border-top: 1px solid #000;">
			<td class="back-bold" colspan="6" style="padding-left: 0px;text-align: left !important; border-bottom:none">
			<div class="clearfix" style="padding-left:8px; padding-right:8px">
					<label class="fl-l" style="width:105px;">Cộng tiền hàng:</label>
					<label class="fl-l input-name" style="width:685px; padding-left:10px ;font-weight: bold;">
					<xsl:choose>
							<xsl:when test="../../Total!=''">
								&#160;  <xsl:value-of select="translate(translate(translate(format-number(../../Total, '###,###'),',','?'),'.',','),'?','.')"/> 
							</xsl:when> 
							<xsl:otherwise>
								&#160;
							</xsl:otherwise>
						</xsl:choose>
					 </label>
				</div>
			</td>
	</tr>	
-->
	<!-- Thuế suất : Có thể bỏ -->
	
    <tr class="noline back" style="">
		<!--<td class="back-bold" colspan="6" style="border-bottom:none">
			<div class="clearfix" style="padding-left:8px; padding-right:8px">
				<label class="fl-l" style="float:left">Thuế suất thuế GTGT <i>(VAT Rate)</i>:</label>
				<label class="fl-l input-name" style="color:#000;">
					<xsl:choose>
						<xsl:when test="../../VAT_Rate!=''">
&#160; <xsl:value-of select="../../VAT_Rate"/>%
						</xsl:when>
						<xsl:otherwise>
&#160;%
						</xsl:otherwise>
					</xsl:choose>
				</label>
				<label class="fl-l" style="float:left; padding-left:238px">Tiền thuế GTGT <i>(VAT Amount)</i>:</label>
				<label class="fl-l">
					<xsl:choose>
					<xsl:when test="../../VAT_Amount='0'">
0
					</xsl:when>
					<xsl:when test="../../VAT_Amount!=''">
						<xsl:value-of select="translate(translate(translate(format-number(../..//VAT_Amount, '###,###'),',','?'),'.',','),'?','.')"/>
					</xsl:when>
					<xsl:otherwise>
&#160;
					</xsl:otherwise>
				</xsl:choose>
				</label>
			</div>
		</td>-->
      <td class="back-bold" colspan="5" style="padding-left: 0px;text-align: left !important; border-right:none !important;">
        <div class="clearfix" style="text-align: right; padding-left:8px">
          <label class="fl-l" style="float:left">
            Thuế suất thuế GTGT <i>(VAT Rate)</i>:
          </label>
          <!--<label class="fl-l input-name" style="color:#000;">
            <xsl:choose>
              <xsl:when test="../../VAT_Rate!=''">
                &#160; <xsl:value-of select="../../VAT_Rate"/>%
              </xsl:when>
              <xsl:otherwise>
                &#160;%
              </xsl:otherwise>
            </xsl:choose>
          </label>-->
          <!--fix new-->
          <label class="fl-l input-name" style="color:#000;">
                                        <xsl:choose>
                                          <xsl:when test="../../VAT_Rate!=''">
                                            <xsl:choose>
                                              <xsl:when test="../../VAT_Rate!='-1' ">
                                                &#160; <xsl:value-of select="../../VAT_Rate"/>%
                                              </xsl:when>
                                              <xsl:otherwise>
                                                &#160;/
                                              </xsl:otherwise>
                                            </xsl:choose>
                                          </xsl:when>
                                          <xsl:otherwise>
                                            &#160;%
                                          </xsl:otherwise>
                                        </xsl:choose>
                                      </label>
          <label class="fl-l" style="float:left; padding-left:208px;">
            Tiền thuế GTGT <i>(VAT Amount)</i>:
          </label>
        </div>
      </td>
      <td style="border-left:none;">
        <div style="width: 120px; text-align: right; padding-left:1px;overflow: hidden; font-weight: bold; display: block; -ms-word-wrap: break-word;">

          
            <xsl:choose>
              <xsl:when test="../../VAT_Amount='0'">
                0
              </xsl:when>
              <xsl:when test="../../VAT_Amount!=''">
                <xsl:value-of select="translate(translate(translate(format-number(../..//VAT_Amount, '###,###'),',','?'),'.',','),'?','.')"/>
              </xsl:when>
              <xsl:otherwise>
                &#160;
              </xsl:otherwise>
            </xsl:choose>
          
        </div>
      </td>
	</tr>
	

	
	<!-- Bảo hiểm y tế trả -->
	  <!--<tr  class="noline back" style="border-bottom: none;">
			<td class="back-bold" colspan="6" style="padding-left: 0px;text-align: left !important; border-bottom:none">
			<div class="clearfix" style="padding-left:8px; padding-right:8px; padding-top:5px">
					<label class="fl-l" style="width:120px;">Số tiền BHYT trả:</label>
					<label class="fl-l input-name" style="width:603px; padding-left:77px ;font-weight: bold;">
					 --><!--   <xsl:value-of select="../../BHYT_Chi" />--><!--					
					<xsl:choose>
							<xsl:when test="../../BHYT_ThanhToan!=0">
								&#160; <xsl:value-of select="translate(translate(translate(format-number(../../BHYT_ThanhToan, '###,###'),',','?'),'.',','),'?','.')"/> đồng
							</xsl:when> 
							<xsl:otherwise>
								&#160; 0 đồng
							</xsl:otherwise>
						</xsl:choose>
					
					 </label>
				</div>
			</td>
	</tr>-->	
		
	<!-- Tổng cộng tiền thanh toán -->
	<tr class="noline back" style="">
		<!--<td class="back-bold" style="text-align: left; border-bottom:none" colspan="6">
		<div class="clearfix" style="padding-left:8px; padding-right:8px">
			<label class="fl-l" style="width:630px;">
				TỔNG CỘNG <i>(Total Amount)</i>:
            </label>
			<label class="fl-l  input-name" style="width:160px;float: left;text-align: left;color:#000;padding-left: 0px;font-weight: bold;height:20px ;border-bottom: 0px dotted #000000  !important">
			   <xsl:value-of select="../../Amount" /> 
				
				<xsl:choose>
					<xsl:when test="../../Amount!=0">
						&#160; <xsl:value-of select="translate(translate(translate(format-number(../../Amount, '###,###'),',','?'),'.',','),'?','.')"/> đồng
					</xsl:when>
					<xsl:otherwise>
						&#160; 0 đồng
					</xsl:otherwise>
				</xsl:choose>
				
				
			</label>
		</div>	
		</td>-->
    <td class="back-bold" colspan="5" style="padding-left: 0px;text-align: left !important;border-right:none !important;">
			<div class="clearfix" style="text-align: right; padding-left:8px">
					<label class="fl-l" style="float:left;">
            TỔNG CỘNG <i>(Total Amount)</i>:
          </label>
				</div>
			</td>
		<td style="border-left:none;">
			 <div style="display: block;word-wrap: break-word;width: 120px;text-align: right;padding-left:1px;  overflow: hidden; font-weight: bold">

         <xsl:choose>
           <xsl:when test="../../Amount!=0 and ../../Amount!=''">
             &#160; <xsl:value-of select="translate(translate(translate(format-number(../../Amount, '###,###'),',','?'),'.',','),'?','.')"/>
           </xsl:when>
           <xsl:otherwise>
             &#160; 
           </xsl:otherwise>
         </xsl:choose>
				</div>
			</td>
	</tr>
	
	<tr class="noline back" style="border-bottom: 1px solid #000"> <!-- border-top: 1px solid #000; border-bottom: 1px solid #000; -->
		<td colspan="6" style="padding-right: 0px;">
			<div class="clearfix" style="padding-left:8px; padding-right:8px; padding-bottom:8px">
				<label class="fl-l" style="width:240px;">
						Tổng số tiền viết bằng chữ <i>(Say)</i>:
				</label>
				<label class="fl-l  input-name" style="width:546px;padding-left: 10px; text-align: left;color:#000 ;border-bottom: 0px dotted #000000  !important">
					<xsl:choose>
						<xsl:when test="../../Amount_words!=''">
&#160;  <xsl:value-of select="../../Amount_words"/>
						</xsl:when>
						<xsl:otherwise>
&#160;
						</xsl:otherwise>
					</xsl:choose>
				</label>
			</div>
		</td>
	</tr>
  <tr>
                                  <td colspan="6" height="20px" style="border:1px solid black;"></td>
                                </tr>

                                <tr>
                                  <td colspan="6" height="70px" style="border:1px solid black;">
                                    Vui lòng trả vào tài khoản số:
                                    <p style="text-transform: uppercase; font-size:13px;float:left;padding-left:150px;">
                                      <label class="">
                                      <b>
                                        <xsl:choose>
                                          <xsl:when test="../../ComBankNo!=''">
                                            <xsl:value-of select="../../ComBankNo"/>
                                          </xsl:when>
                                          <xsl:otherwise>
                                            &#160;
                                          </xsl:otherwise>
                                        </xsl:choose> (VNĐ)</b> - NH Á Châu - PGD Sự Vạn Hạnh - TP.Hồ Chí Minh - việt nam
                                      </label>
                                      <br/>
                                    <b>110000188174 (VND)</b> - NH vietinbank - Chi Nhánh 7- TP.Hồ Chí Minh - Việt nam
                                    </p>
                                    
                                  </td>
                                </tr>
<!-- Tạm ứng -->
	 <!--<tr  class="noline back" style="border-bottom: none;">
			<td class="back-bold" colspan="6" style="padding-left: 0px;text-align: left !important; border:none !important">
			<div class="clearfix" style="padding-top:8px;">
					<label class="fl-l" style="width:100px;">Tiền tạm ứng:</label>
					<label class="fl-l input-name" style="width:165px; padding-left:15px ;font-weight: bold;">
					    <xsl:choose>
							<xsl:when test="../../Tam_Ung!=0">
								&#160;  <xsl:value-of select="translate(translate(translate(format-number(../../Tam_Ung, '###,###'),',','?'),'.',','),'?','.')"/> đồng
							</xsl:when> 
							<xsl:otherwise>
								&#160; 0 đồng
							</xsl:otherwise>
						</xsl:choose>
						
					 </label>
				</div>
			</td>
	</tr>-->	
	<!-- Hoàn lại-->
	  <!--<tr  class="noline back" style="border-bottom: none">
			<td class="back-bold" colspan="6" style="padding-left: 0px;text-align: left !important; border:none !important">
			<div class="clearfix" style="">
					<label class="fl-l" style="width:100px;">
						--><!--<xsl:choose>
								<xsl:when test="../../Extra=1">
									Tiền hoàn lại: 
								</xsl:when> 
								<xsl:when test="../../Extra=0">
									Tiền thu thêm: 
								</xsl:when> 
								<xsl:otherwise>
									Tiền hoàn lại:
								</xsl:otherwise>
							</xsl:choose> --><!--
							Tiền hoàn lại: 
					</label>	
					<label class="fl-l  input-name" style="width:165px; padding-left:15px ;font-weight: bold ;border-bottom: 1px dotted #000000  !important">
					     <xsl:choose>
							<xsl:when test="../../Hoan_Lai!=0">
								&#160;  <xsl:value-of select="translate(translate(translate(format-number(../../Hoan_Lai, '###,###'),',','?'),'.',','),'?','.')"/> đồng
							</xsl:when> 
							<xsl:otherwise>
								&#160; 0 đồng
							</xsl:otherwise>							
						</xsl:choose>
					 </label>
				</div>
				
			</td>
	</tr>-->	
	 <!--<tr  class="noline back" style="border-bottom: none; border-top:none">
			<td class="back-bold" colspan="6" style="padding-left: 0px;text-align: left !important; border:none !important">
			<div class="clearfix" style="padding-bottom:5px">
					<label class="fl-l" style="width:100px;">						
							Tiền thu thêm: 
					</label>	
					<label class="fl-l  input-name" style="width:165px; height:20px ;padding-left:15px ;font-weight: bold ;border-bottom: 1px dotted #000000  !important">
					      --><!--
					       <xsl:choose>
							<xsl:when test="../../Extra!=''">
								&#160;  <xsl:value-of select="translate(translate(translate(format-number(../../Extra, '###,###'),',','?'),'.',','),'?','.')"/> đồng
							</xsl:when> 
							<xsl:otherwise>
								&#160; 0 đồng
							</xsl:otherwise>
						</xsl:choose>  
						--><!--
					   <xsl:choose>
							 <xsl:when test="../../Extra!=''">			
									 	 <xsl:choose>
											<xsl:when test="../../Extra!=0">
												&#160;  <xsl:value-of select="translate(translate(translate(format-number(../../Extra, '###,###'),',','?'),'.',','),'?','.')"/> đồng
											</xsl:when> 
											<xsl:otherwise>
												&#160; 0 đồng
											</xsl:otherwise>
										</xsl:choose>					
								</xsl:when>								 
								<xsl:otherwise>
								&#160; 0 đồng
							    </xsl:otherwise>	
							</xsl:choose> 
	
					 </label>
				</div>
				
			</td>
	</tr>-->	


    </xsl:template>
    <xsl:template name="addchuky">
    <tr  class="noline back">
	   <td colspan="6" style="border-bottom: none; border-right: none;border-left: none">
			<table>
        <tr>
            <td colspan="2" style="text-align:center; margin-top:0px; border: none!important">
                <b style="margin-right:0px">Người mua hàng</b>
            </td>
            
            <td colspan="2" style="text-align:center; margin-top:0px; border: none!important">
                <!--<b style="margin-left:0px">Người bán hàng </b>-->
            </td>
            <td colspan="2" style="text-align:center; margin-top:0px; border: none!important; ">
                <b style="margin-left:0px">Người bán hàng</b>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center; border: none!important">
                <i style="margin-left:0px"> (Ký, ghi rõ họ tên)</i>
            </td>
            <td colspan="2" style="text-align:center;border: none!important;">
                <!--<i style="margin-left:0px"> (Ký, ghi rõ họ tên)</i>-->
            </td>
            <td colspan="2" style="text-align:center; border: none!important">
                <i style="margin-left:0px"> (Ký, ghi rõ họ tên)</i>
            </td>
        </tr>

        <!--<tr>
            <td colspan="2" style="text-align:center; border: none!important">
                <i style="margin-left:0px"> (Sign,full name)</i>
            </td>
            <td colspan="2" style="text-align:center; border: none!important; border-left: none!important">
               
            </td>
            <td colspan="2" style="text-align:center; border: none!important">
                <i style="margin-left:0px"> (Sign, full name)</i>
            </td>
        </tr>-->
        <tr>
            <td colspan="2" style=" border: none!important">
                <div class="payment fl-l" style="width:200px;float:left;">&#160; </div>
            </td>
            <td colspan="2" style="  border: none!important;">
   
            </td>
            <td colspan="2" style="  border: none!important" align="center">
                <div class="payment fl-l" style="width:200px; margin-right: 80px; float: right">
                    <p style="font-size:12px; margin:0px;color:red!important;" class="ComNameSignDate">
                        <xsl:variable name="serial">
                            <xsl:value-of select="../../SerialNo" />
                        </xsl:variable>
                        <xsl:variable name="pattern">
                            <xsl:value-of select="../../InvoicePattern" />
                        </xsl:variable>
                        <xsl:variable name="invno">
                            <xsl:value-of select="../../InvoiceNo" />
                        </xsl:variable>
                        <xsl:choose>
                            <xsl:when test="/Invoice/image != '' ">
                                <div class="bgimg" style="width:185px;background:url({/Invoice/image/@URI}) no-repeat center center" onclick="showDialog('dialogServer','{$serial}','{$pattern}','{$invno}',0,'messSer','is')">
                    <p style="color:red!important">
                        <xsl:value-of select="/Invoice/image" />
                    </p>
                    <p style="color:red!important">
                        Ký bởi:
                      <xsl:choose>
							<xsl:when test="/Invoice/CNCom!=''">
								<xsl:value-of select="/Invoice/CNCom" />
							</xsl:when> 
							<xsl:otherwise>
								
							</xsl:otherwise>
						</xsl:choose>  
                      <xsl:choose>
							<xsl:when test="/Invoice/ComName!=''">
								<xsl:value-of select="/Invoice/ComName" />
							</xsl:when> 
							<xsl:otherwise>
								
							</xsl:otherwise>
						</xsl:choose>  
                     
                        <br />
                        Ký ngày: <xsl:value-of select="/Invoice//Content/SignDate" />
                    </p>
                </div>
                </xsl:when>
                </xsl:choose>
                </p>
                </div>
            </td>
        </tr>

<tr>
	   <td colspan="6" style="text-align:center; border-right: none!important; border-left: none!important">
	  <xsl:value-of select="../../isReplace"/>
		 <xsl:value-of select="../../isAdjust"/>
		 <xsl:choose>
		   <xsl:when test="/Invoice/convert!=''">
			 <div style="text-align:center;margin-bottom:30px;">
			   <div>
				 <p style="font-size:16px; margin:0px">
				   <b style="color:#584C56">
             Ngày chuyển đổi:
					 <xsl:value-of select="substring(/Invoice/ConvertDate,1,2)"/>
				    / 
					 <xsl:value-of select="substring(/Invoice/ConvertDate,4,2)"/>
				    /
					 <xsl:value-of select="concat('20',substring(/Invoice/ConvertDate,9,2))"/>
				   </b>
				 </p>
				 <!--<p style="font-size:10px; margin:0px">
				   Người chuyển đổi
				 </p>
				 <i style="font-size:10px; margin:0px">
				   ( Signature of converter )
				 </i>
				 <p style="margin-top:60px">
				  <xsl:value-of select="../../ConvertBy"/>
				</p>--><!--<p style="font-size:14px; margin:0px">
				  Thủ trưởng đơn vị
				</p>-->
			   </div>
			 </div>
		  </xsl:when>
   </xsl:choose>
	   </td>

	 </tr>
    </table>
       <div style="font-size:12px; width:826px; text-align: center; border-top:1px solid;">
											Đơn vị cung cấp giải pháp hóa đơn điện tử: Tổng công ty dịch vụ viễn thông - VNPT Vinaphone, MST:0106869738, Điện thoại:18001260
										</div>
										<div class="clearfix" id="bt"> &#160; </div>
		 </td>
	   </tr>
      
	 

   
    </xsl:template>

	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
				<!--<link href="styles.css" type="text/css" rel="stylesheet" />-->
				<title>VAT</title>
				<style type="text/css" rel="stylesheet">
          html, body
          {
          margin: 0;
          padding: 0;
          height: 100%;
          background-color: white;
          }
          #main
          {
          margin: 0 auto;
          }
          .VATTEMP
          {
          background-color: white;
          background:url() no-repeat;
          font-family: Time new roman;
          width: 878px  !important;
          font-size: 16px;
          overflow: auto;
          margin-left:20px;
          }
          .VATTEMP .header-main, .content
          {
          width: 790px;
          }
          .VATTEMP #logo
          {
          float: center;
          width: 172px;
          height: 90px;
          background: url(data:image/png;base64,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) no-repeat;
          /*margin-left: 25px;*/
          /*margin-top: 10px;*/
          margin:0 auto;
          }
          .VATTEMP .header
          {
          float: right;
          width: 613px;
          }
          .VATTEMP .header-content
          {
          float: left;
          text-align: center;
          width: 400px;
          }
          .VATTEMP .header h2
          {
          font-size: 1em;
          }
          .VATTEMP .header h2, .header p
          {
          margin: 0;
          }
          .VATTEMP .header p.name-upcase
          {
          font-size: 16px;
          text-transform: uppercase;
          }
          .VATTEMP .header-note
          {
          float: right;
          font-size: 100%;
          width: 175px;
          margin-top: 0;
          }
          .VATTEMP .header .number
          {
          font-family: Time new roman;
          font-size: 100%;
          }
          .clearfix:after
          {
          clear: both;
          content: ".";
          display: block;
          height: 1px;
          overflow: hidden;
          visibility: hidden;
          }
          .clearfix
          {
          clear: both;
          }
          .VATTEMP .input-code
          {
          border: 1px solid #584d77;
          float: left;
          font-weight: normal;
          text-align: center;
          width: 18px;
          height: 14px;
          }
          .VATTEMP div label.fl-l, div label
          {
          margin-right: 0;
          /* margin-top: 3px; */
          }
          .VATTEMP .input-name, .input-date
          {
          border: 0;
          border-bottom: 1px dotted #000;
          }
          .VATTEMP .statistics
          {
          clear: both;
          margin-right: 0;
          padding-top: 2px;
          }
          .nenhd
          {
          position: relative;
          float: left !important;
          }
          .nenhd_bg
          {
          background-image: url('data:image/png;base64,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UHNlbnVtAAAAAFBnUHMAAAAAUGdQQwAAAABMZWZ0VW50RiNSbHQAAAAAAAAAAAAAAABUb3AgVW50RiNSbHQAAAAAAAAAAAAAAABTY2wgVW50RiNQcmNAWQAAAAAAAAAAABBjcm9wV2hlblByaW50aW5nYm9vbAAAAAAOY3JvcFJlY3RCb3R0b21sb25nAAAAAAAAAAxjcm9wUmVjdExlZnRsb25nAAAAAAAAAA1jcm9wUmVjdFJpZ2h0bG9uZwAAAAAAAAALY3JvcFJlY3RUb3Bsb25nAAAAAAA4QklNA+0AAAAAABAASAAAAAEAAgBIAAAAAQACOEJJTQQmAAAAAAAOAAAAAAAAAAAAAD+AAAA4QklNA/IAAAAAAAoAAP///////wAAOEJJTQQNAAAAAAAEAAAAeDhCSU0EGQAAAAAABAAAAB44QklNA/MAAAAAAAkAAAAAAAAAAAEAOEJJTQQKAAAAAAABAAA4QklNJxAAAAAAAAoAAQAAAAAAAAACOEJJTQP1AAAAAABIAC9mZgABAGxmZgAGAAAAAAABAC9mZgABAKGZmgAGAAAAAAABADIAAAABAFoAAAAGAAAAAAABADUAAAABAC0AAAAGAAAAAAABOEJJTQP4AAAAAABwAAD/////////////////////////////A+gAAAAA/////////////////////////////wPoAAAAAP////////////////////////////8D6AAAAAD/////////////////////////////A+gAADhCSU0EAAAAAAAAAgALOEJJTQQCAAAAAAAaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4QklNBDAAAAAAAA0BAQEBAQEBAQEBAQEBADhCSU0ELQAAAAAABgABAAAARDhCSU0ECAAAAAAAEAAAAAEAAAJAAAACQAAAAAA4QklNBB4AAAAAAAQAAAAAOEJJTQQaAAAAAANXAAAABgAAAAAAAAAAAAAEKQAAAzQAAAARAHQAYQBpAHQAYQBfAGgAbwBhAGQAbwBuAF8AIABuAGUAdwAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAADNAAABCkAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAQAAAAAAAG51bGwAAAACAAAA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ZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS4zLWMwMTEgNjYuMTQ1NjYxLCAyMDEyLzAyLzA2LTE0OjU2OjI3ICAgICAgICAiPg0KCTxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+DQoJCTxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wUmlnaHRzPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvcmlnaHRzLyIgZGM6Zm9ybWF0PSJpbWFnZS9qcGVnIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzYgKFdpbmRvd3MpIiB4bXA6Q3JlYXRlRGF0ZT0iMjAxNy0wMy0xOFQwMTowMjowOC0wNzowMCIgeG1wOk1vZGlmeURhdGU9IjIwMTctMDctMDZUMTQ6MTI6NTYrMDc6MDAiIHhtcDpNZXRhZGF0YURhdGU9IjIwMTctMDctMDZUMTQ6MTI6NTYrMDc6MDAiIHhtcE1NOkRvY3VtZW50SUQ9InV1aWQ6RDM3MUQ0MkFCMTBCRTcxMThCRDdCRDkxRDI1MkVCRTYiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6M0JEN0I0Q0MxOTYyRTcxMUFDRUQ5QUYzQjM0QjczNzciIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0idXVpZDpEMzcxRDQyQUIxMEJFNzExOEJEN0JEOTFEMjUyRUJFNiIgcGhvdG9zaG9wOkNvbG9yTW9kZT0iMyIgcGhvdG9zaG9wOklDQ1Byb2ZpbGU9InNSR0IgSUVDNjE5NjYtMi4xIiB4bXBSaWdodHM6TWFya2VkPSJGYWxzZSI+DQoJCQk8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDozQUQ3QjRDQzE5NjJFNzExQUNFRDlBRjNCMzRCNzM3NyIgc3RSZWY6ZG9jdW1lbnRJRD0idXVpZDpEMzcxRDQyQUIxMEJFNzExOEJEN0JEOTFEMjUyRUJFNiIgc3RSZWY6b3JpZ2luYWxEb2N1bWVudElEPSJ1dWlkOkQzNzFENDJBQjEwQkU3MTE4QkQ3QkQ5MUQyNTJFQkU2Ii8+DQoJCQk8eG1wTU06SGlzdG9yeT4NCgkJCQk8cmRmOlNlcT4NCgkJCQkJPHJkZjpsaSBzdEV2dDphY3Rpb249InNhdmVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjQ5MkZBRDdGQjEwQkU3MTE4OEYyOTk3OEQyNEU1MjlCIiBzdEV2dDp3aGVuPSIyMDE3LTAzLTE4VDE1OjA0OjIzKzA3OjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ1M2IChXaW5kb3dzKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPg0KCQkJCQk8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6M0FEN0I0Q0MxOTYyRTcxMUFDRUQ5QUYzQjM0QjczNzciIHN0RXZ0OndoZW49IjIwMTctMDctMDZUMTQ6MTI6NTYrMDc6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCBDUzYgKFdpbmRvd3MpIiBzdEV2dDpjaGFuZ2VkPSIvIi8+DQoJCQkJCTxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjb252ZXJ0ZWQiIHN0RXZ0OnBhcmFtZXRlcnM9ImZyb20gYXBwbGljYXRpb24vdm5kLmFkb2JlLnBob3Rvc2hvcCB0byBpbWFnZS9qcGVnIi8+DQoJCQkJCTxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJkZXJpdmVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJjb252ZXJ0ZWQgZnJvbSBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wIHRvIGltYWdlL2pwZWciLz4NCgkJCQkJPHJkZjpsaSBzdEV2dDphY3Rpb249InNhdmVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjNCRDdCNENDMTk2MkU3MTFBQ0VEOUFGM0IzNEI3Mzc3IiBzdEV2dDp3aGVuPSIyMDE3LTA3LTA2VDE0OjEyOjU2KzA3OjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ1M2IChXaW5kb3dzKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPg0KCQkJCTwvcmRmOlNlcT4NCgkJCTwveG1wTU06SGlzdG9yeT4NCgkJCTxwaG90b3Nob3A6RG9jdW1lbnRBbmNlc3RvcnM+DQoJCQkJPHJkZjpCYWc+DQoJCQkJCTxyZGY6bGk+MTFCOTU4OTE0ODRBODZEQTUxMzRFMDEzNjE3NkJENzM8L3JkZjpsaT4NCgkJCQkJPHJkZjpsaT5CNjM2NDM4MjU2QjlGMjJFQzI0N0MwNTU0REZBN0EyRDwvcmRmOmxpPg0KCQkJCQk8cmRmOmxpPnV1aWQ6RDM3MUQ0MkFCMTBCRTcxMThCRDdCRDkxRDI1MkVCRTY8L3JkZjpsaT4NCgkJCQkJPHJkZjpsaT54bXAuZGlkOjI1QUFFM0RBQTI5OUU0MTE5OTY5RjgwQUUzQTQ0RjMyPC9yZGY6bGk+DQoJCQkJPC9yZGY6QmFnPg0KCQkJPC9waG90b3Nob3A6RG9jdW1lbnRBbmNlc3RvcnM+DQoJCTwvcmRmOkRlc2NyaXB0aW9uPg0KCTwvcmRmOlJERj4NCjwveDp4bXBtZXRhPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgPD94cGFja2V0IGVuZD0ndyc/Pv/iDFhJQ0Nf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gQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP34ooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoooNABRTVGO+aVjtUn0HagNOgtIzrEpZjhVGSfQVmaz4ms9Et2kmmLbRkIp+b8q4XxN4/vdWLLCzQ2rcDaxVj9aHJI7sLl9avsrHp0W103q25W6c0VzPw88RjWdI8pjtmi42+o9a6KDdt+bmopzUldHJiKbo1XSkSUUUVZAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFBOKACkc4Q56Y5o3ZHp71ieI/HdloatHu86Y8bVPT60uZLUqnTlUdoo1rm7isLfzJHVFHOSa43xP8AEhrkPb6f7iSQ8YHfb71zut6/ca5OzSSSeV1VCx2g/Ss3caweJXY+iweUwptOpqWbiZ53aSRmeT+8xy351XyXcZ+bnv3o8wj+83t61t+GvA15rh86RPs9vnjPBxXLeb0PZqYiFJatIq+GdQuNM1aOS1QySM4DD2z0r1eKQukZ243Lk+x4rM0Xwla6Kg2RxmT++VG4n61rAbVxXdTp8iPkMyxFOrPmgFFFFaHCFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAU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iiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiihhkUAFB6UwuttCWkbaqjJJ7CuD8afEiSe5a0sd6qOGlBwCPY1NSSitTqw2EnXnywOj8QeOLHQwY/M8ybsq+tcbrvjPUNXDq0iwW7A4WNiGb2NYMjebMZG+aQ9WPLH8aDya8/2kj6bB5VTp6zWorOzdST9aQcUUUc0z0/Z+gu8+ppF2h1LD5QcnHWijNHNIUk+xq6F4wvNCmZlaWS2XnY7k8ewr0Hwz4pt/E1nvhO2QfeU9RXlRdj3NS2GozaTOJoWdGU7iFJG7HY041JJnj4zL41NYaHsg+aNq5f4i+HhfWQuo0Xz4BluOdnU1q+Fdej8R6XHMrYdRh1z0NaM9us67XVXVhtYEZDD0NdnN7TY+fpVJ0a1+x46yjaeB09KhIyK3PGnh1vDupOseWt7jLgkfc9hWHXJUpuG59dQqRq0+eIsbeWV/uqc4rrfhr4n8i7/s6V2ZGO5GZs4J7CuRqSzla2uo3jbYysGB6YINXRqKOgYqlGtS5Hue0UVzPg7x7HrEXl3H7q4Q7cMcb/cVvNeRkbvMVVHJ+bpXbpufG18PUpS5Wiwenp7+lYfj7VItI0Kb5v3tyhiC565GM4qPXvH9jpCFVfz5G4wpyPxrhNe1uXXr1ppS20A7FJ4H0rneIWx3YPLatWSlsjP3n1NCttYE9jSAZPFWNP0+bU7pYbdPMdiFIx93Ncii2fVPliuZvY2Ph7oP9qa2kjYNvZHcWP8AE3UCvSlAIrO8MeGIfD+mLCnLMQ8h9WrT6V30qbgfF43EuvU5logooorQ5QooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKD0oAKRnEalm6LyaIzxXNfEfxE2iab5ELN5lxlc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5eR4ZG3RbmLAfSsPFZVavLofSYPLqMKSrS95sJD5jMzfMzDknqa7j4ZeJ1MH9nz/ACyKcx57+1cPUlteSWV1HcJu8yIhhzycc4rjjOVztxWFjWp8stz2iis/w1rsfiDS45lPzY+Yehq9JwOc474r0bo+QlTlGThLcdSOcIf61Q1fxBa6Pbb5pPoAeSa4fxH8RLjWC0Nrvt4x1bdhmFEmkdWFwFWvsrIvfEy+sbxY1jbddRcbk6geh9q42l3EyM2Tub7x7n60leXU953PrsJhfYUuRBmnLIVYEnoabRQWt9TrPht4l+z3Zs5GJhkI8ssc4Y9q78jvXiscjW+0xsybTuXacbSOhHvXp/gjxKviXSUdvlmi+VgT973rsp4hLQ+ezjDWn7WGzNPUtMg1fT5LeZVaORSOn3c9x71514m8H3Xh+SQ+Wslrg7WA+YfWvTsUy4gW5hZJEWRWGCrDINbVKakebg8ZPDyutjxaivQtc+GNnfs0lqXt5vQf6sf8B6Vz958N9St3/drHcqDz/Bmub6s7XufS4fMKFVXbt6nOnmhfk6cfStyTwNqhjbbp67scfve9Osvhtqkw/fQxxe4lzisFFsv65R/mMMEyOMnv3p1np8mqXnlwwzSMp4Kn5Sff2rtdL+FsKlTcu7NnscZrp9O0a10iIJbxRx+pC8muhYZp7nHis2pU9IanN+GfhktkVnvv3smQwjA+VT711iQokaoFUKvQAcCpKMV0cqPn61edV3mwHAoooqjEKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoooPSgAoprHEX86jur2GwtjJNIsaAZJY4o6XBXcuVEzNsGeuOeKp3/iOx050WaZQ0jBQoPIz61x/iX4nvdyva6cDGo4eVuCR/sn1rl7qZp5GkkZnlxnexy351z/WF2PWw+T1qqvseyI6tFuX5lboc0VzXw68SrrGmLE/yyxcbfUetdJnIrWnUUjz61GVObgzC8deHF8QaHJt/4+IcyJ65HOPxrzWQMbhvMTy/LG0gDGTXsxRT/CM/SvP/AIke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AooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiihhlaAew2aQJEzMdq45PpXn3j7xob+RrK3Zlj6OVON47g+3tW38SNfOk6UttGW86fg4PKqetedsdzbjy3qa5qmJUdLHvZRgeePtZjkdsKuTt9O1SC381gqruZuFA6k1CTxXe+APCeLOO9uo18w8oGXp6H61lSp8zue5jMYsPT5rmf4a+GLzx+dfsRG3IQdR9a7PTtJt9Ktljt4Yo9uOdoyatKv+1mlIHXFdvLE+PxGMlVd5sXdSHDUhf5c/zqlqHiWy00fvrhFPoDnNLlic8Iyn8CZdEa49acxwK5m7+KOn25wu+T6Cof8Aha1nN8vlyDdxnFVzI6o4Ou94nVFsp65rF8c+G/7f0p5EZlmhRmUA9TjpVrRvEVrrEW2GZSw/hJ5FaEiZX/PNEbSWhz+/RrXeh4y4Zp23oI/LG0gDGTUddZ8Q/C7abMbyFd0MnD8cKfWuTry6l4Ox9nQrRq0+eAZxWx4O8YSeG7jZIrSQMw4z0+lY9AO38OntTWjuViKcatPkkeuab4ms9Th3xzDc38LHpSah4rsNLQma4UMBkKOSfavJhIwz8zfNweetNVivTj6V1/Wl2PHWSU7/ABM6bxT8QpNbDw2zNBCM5OcFx6VzPb8c0BQ7rkZ571Yji3yKqpuZjgADrXLU55s9ujh40IWpKxXA3HHrXafD/wAFMqi9ukBfOURhkAetL4W8AbmW4vFUrkMse3+ddqkaxoqqoVVGAB2roWHad2eHmmYJvlpggyKD9+nUV1Hz01dhRRRQMKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigApHbapPpS02YZib6UDjueW+MNQbUfEc0m5mWNSmM8Cser2sjbql2P9s1Rry6vvO6Pu6MYxoLkAHHbPt616p4Z1mDUNFg2you1dpBPSvKwcGnRStAMIzICcnacZrejWUNzlx2EjiYcr3PXbrX7HTYmaS6hG0ZPOcVzWs/FmGD5bOFrkno33QD6muGd2kbLEsfU0hG7rWrxK7HDhcnpw/iam1q3i3U9bibdN5UZBDIrEBh3GKx/MbGNzYPUZpoYgUVy88j2KOFpUvgAcUodh/EfzpKKXNI2lzLZEtjcvZXSyRu0bbgSynaTXpXg7xSviGwAk+WaLgjPUeteYou9wp4DHBNavhLVf7K16ORWZopHWI8+pxV0JOLszy8wwsK9O73R6df6fDqdhJbyqDHKpU+2e/1rzfxb4RuvD1wzCNZLQ/dZR8w+teoRyLJArL91hkVHdWyXcDRyIsisCCGGQa7alNTPnMHi54eV47Hi9Fegav8AC6zv2Z7eRreX2zsH4dKz/wDhUMqfN/aUZxzjyhzXP9Wfc95Zth31OPpVG5hk4GeSBnFdvbfCndjzrxWHcJEBkfWtnTPA+n6UyYgWRlIIZ13EH6044Z33FLNqS2OI0bwXea3IhVFWDcP3jfKcfTvXa6L4Hs9H2ttWWZSCWkG7B9R6VtrGqrgKAPTFLtHoPyrpUYo8fFZlWrbaIRUAp1FFM4LvqFFFFAgooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoY4Wig9KAPOfiDof9lX7TRp+5uMknH3W9K5mvYdV0qHWbF4ZkVkYEcj7vuPf3rzvxJ4HvNIuGdY/Os15GwfP+Ncjw73ufS5Tjoez9nN6mFRUjARuP3UkZz0fvStbSzncqbQvPC5/SuazPXsyKlX7w+tX7Lw7fakB5VlJKT0bPlqD710Gj/CuacK15IIRkbkT5iR357VSi2clbHUaa3OXCAn7v5DJq7aeFL3U1HkWrfNwGf5dvvivRNL8IabpAXy4Vd1OVaVdzA+xIrRESj+Guj6s+55E84dvdR5fq3gy80mz3zRE7Rksg4GPWsWvZNR8v7HIs21oyp3humO+fwryOby2mYx4MRaTafXrisalPkPTynHVKqakV6ksjsuIlX5V3g4Hrmo2+7W14K0T+1/EcJxujhw7KR8pwc9KmO6OvEtQpOT7Hp0Y2wqo4UKuAO1SUY4or0j4cT5qBnNLRQMN1G6iigXKgooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoPSiigBqbe1OYbhzzRjFFAcqWxTuNBs7tt0tnayMOhaMNj9KWPRbSAhktbdCvIKxgYP5VbxQTU8qKcprqxkeAaXB3UADPSmzXEcP33CfU0WiTK0tiQjd15xTZX8uJmPAUZJPasbW/G9joULbpGmbHIQ5xXG694+vNaV1j3Q2rggYOGIPrU+1SO7C5fWq62sX/Gfjn7c0lhak7dp8yUdD/s1yKjbGqjhV6AdBQDhNv8Oc47U6EZlX5d3I4HeuWpU52fS4fD+yVkrDQrOdqjczcKPU16T4A8N/8I/piyS83FxySeoHpWZ4L8GYZby8jTdnMce37voT712gjX5ePu9K0WHad2zyM4x3P7lMdRRRXUeGFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAFTXLqay02SS3TzJQpIB9cVxB+JeoC4aOSGGNk616EVBGMdf1rzf4geHG0vUWnRcwzcliPun0oe10eplcac58lRDbr4h6lKfkVVXvg1maj4hvNUO6SaZfbeaohivc0Fy33j+dea5TZ9PHC047RQvmNuzubJ6nPWhdzuBnljjmpILdrllWO3mlZjhdnTNdNofw1mu1SS+Xy48g7E4bHvWcac2xVcZSpLdI5my0e61e7EcKFmB4Zfu/j7V3XhX4dQ6QqzXmJpiQQCMhTXRaVodnpFtttII4/UhcMfqatYzXZHDtO9z5vGZtUq6Q0Q1Y1U8duB7U6iiuo8rmfUKKKKBBRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABQTgUUUDW43fhd1U9d0ldc0yaLCkuhC7hkKccGiimKNSUK3unD23ww1CS6ZZGjSMdGA61sWHwqtYipuHaQg8gHANFFL2cT1KmY12rXOk03RLfSIttvHGo/3amMTGQGiijlSPHqN1HeRJmiiig0CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA//Z');
          height:504px;
          left: 0px;
          margin: 0 auto;
          position: absolute;
          top: 290px;
          width: 819px;
          z-index: 1;
          background-repeat: no-repeat;
          }
          .VATTEMP .statistics table
          {
          background-position: bottom;
          border: 0 #fff;
          font-size: 100%;
          margin: 0;
          position: relative;
          z-index: 2;
          width: 100%;
          }
          table
          {
          border-collapse: collapse;
          }
          .VATTEMP .statistics table th
          {
          font-size: 100%;
          text-transform: none;
          font-weight: bold;
          border-bottom: 1px solid #000;
          border-right: 1px solid #000;
          border-left: 1px solid #000;
          border-top: 1px solid #000;
          }
          .VATTEMP .statistics table th.h2
          {
          font-size: 100%;
          text-transform: none;
          font-weight: normal;
          border-bottom: 1px solid #000;
          border-right: 1px solid #000;
          border-left: 1px solid #000;
          border-top: 1px solid #000;
          }
          .VATTEMP .statistics table td.stt
          {
          text-align: center;
          padding-left: 0;
          }
          .VATTEMP .statistics table td.stt2
          {
          text-align: center;
          color: #584d77;
          }
          .VATTEMP .statistics table .back td
          {
          color: #000;
          font-family: Time new roman;
          font-size: 100%;
          }
          .VATTEMP .statistics table .noline td
          {
          border-bottom: 0px solid #000;
          border-right: 1px solid #000;
          border-left: 1px solid #000;
          border-top: 0 none;
          }
          .VATTEMP .statistics table td
          {
          border:0px #fff;
          /*border-right: 2px solid #584d77;
          border-left: 2px solid #584d77;
          padding-left: 5px;
          */
          padding-top: 2px;
          padding-bottom: 2px;
          padding-right: 2px;

          }
          .VATTEMP .statistics tr td.back-bold
          {
          font-size: 100%;
          /*border-bottom: 1px solid #584d77;*/
          }
          .VATTEMP .statistics table .back-bold
          {
          padding-right: 5px;
          text-align: right;
          }
          .VATTEMP .statistics tr td.back-bold2
          {
          font-size: 100%;
          border-bottom: 1px dotted #584d77;
          }
          .VATTEMP .statistics tr td.back-bold3
          {
          font-size: 100%;
          border-bottom:none!important;
          }
          .VATTEMP .statistics table .back-bold2
          {
          padding-left: 5px;
          text-align: left;
          }
          .VATTEMP .statistics tr.bg-pink td
          {
          font-size: 100%;
          text-align: right;
          background: none repeat scroll 0 0 #fedccc;
          }
          .VATTEMP .payment, .date
          {
          margin: 20px 0;
          text-align: center;
          width: 35%;
          }
          .VATTEMP .payment
          {
          float: left;
          }
          .VATTEMP .payment p, .date p
          {
          margin: 0;
          }
          .VATTEMP .date
          {
          float: right;
          height: 120px;
          }
          .VATTEMP .input-date
          {
          width: 40px;
          }
          .VATTEMP .input-name, .back-bold, .input-date
          {
          font-family: Time new roman;
          font-size: 100%;
          }
          .fl-l
          {
          float: left;
          min-height: 16px;
          }
          .bgimg
          {
          border: 1px solid #000;
          cursor: pointer;
          width: 170px;
          }
          .bgimg p
          {
          color: #584d77;
          padding-left: 16px;
          text-align: left;
          }
          p
          {
          font-size: 16px;
          }
          .item
          {
          color: #584d77;
          }
          /*fix css*/
          img#imgCancel{
          width: 830px !important;
          left: 0px;
          }
        </style>
        
		
		
			<xsl:text disable-output-escaping="yes">
			
	<![CDATA[
        
		<script>
		
		    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE 8");
	   if(msie != -1)
	   {
		
          /*! jQuery v1.7.2 jquery.com | jquery.org/license */
(function (a, b) {
    function cy(a) { return f.isWindow(a) ? a : a.nodeType === 9 ? a.defaultView || a.parentWindow : !1 } function cu(a) { if (!cj[a]) { var b = c.body, d = f("<" + a + ">").appendTo(b), e = d.css("display"); d.remove(); if (e === "none" || e === "") { ck || (ck = c.createElement("iframe"), ck.frameBorder = ck.width = ck.height = 0), b.appendChild(ck); if (!cl || !ck.createElement) cl = (ck.contentWindow || ck.contentDocument).document, cl.write((f.support.boxModel ? "<!doctype html>" : "") + "<html><body>"), cl.close(); d = cl.createElement(a), cl.body.appendChild(d), e = f.css(d, "display"), b.removeChild(ck) } cj[a] = e } return cj[a] } function ct(a, b) { var c = {}; f.each(cp.concat.apply([], cp.slice(0, b)), function () { c[this] = a }); return c } function cs() { cq = b } function cr() { setTimeout(cs, 0); return cq = f.now() } function ci() { try { return new a.ActiveXObject("Microsoft.XMLHTTP") } catch (b) { } } function ch() { try { return new a.XMLHttpRequest } catch (b) { } } function cb(a, c) { a.dataFilter && (c = a.dataFilter(c, a.dataType)); var d = a.dataTypes, e = {}, g, h, i = d.length, j, k = d[0], l, m, n, o, p; for (g = 1; g < i; g++) { if (g === 1) for (h in a.converters) typeof h == "string" && (e[h.toLowerCase()] = a.converters[h]); l = k, k = d[g]; if (k === "*") k = l; else if (l !== "*" && l !== k) { m = l + " " + k, n = e[m] || e["* " + k]; if (!n) { p = b; for (o in e) { j = o.split(" "); if (j[0] === l || j[0] === "*") { p = e[j[1] + " " + k]; if (p) { o = e[o], o === !0 ? n = p : p === !0 && (n = o); break } } } } !n && !p && f.error("No conversion from " + m.replace(" ", " to ")), n !== !0 && (c = n ? n(c) : p(o(c))) } } return c } function ca(a, c, d) { var e = a.contents, f = a.dataTypes, g = a.responseFields, h, i, j, k; for (i in g) i in d && (c[g[i]] = d[i]); while (f[0] === "*") f.shift(), h === b && (h = a.mimeType || c.getResponseHeader("content-type")); if (h) for (i in e) if (e[i] && e[i].test(h)) { f.unshift(i); break } if (f[0] in d) j = f[0]; else { for (i in d) { if (!f[0] || a.converters[i + " " + f[0]]) { j = i; break } k || (k = i) } j = j || k } if (j) { j !== f[0] && f.unshift(j); return d[j] } } function b_(a, b, c, d) { if (f.isArray(b)) f.each(b, function (b, e) { c || bD.test(a) ? d(a, e) : b_(a + "[" + (typeof e == "object" ? b : "") + "]", e, c, d) }); else if (!c && f.type(b) === "object") for (var e in b) b_(a + "[" + e + "]", b[e], c, d); else d(a, b) } function b$(a, c) { var d, e, g = f.ajaxSettings.flatOptions || {}; for (d in c) c[d] !== b && ((g[d] ? a : e || (e = {}))[d] = c[d]); e && f.extend(!0, a, e) } function bZ(a, c, d, e, f, g) { f = f || c.dataTypes[0], g = g || {}, g[f] = !0; var h = a[f], i = 0, j = h ? h.length : 0, k = a === bS, l; for (; i < j && (k || !l) ; i++) l = h[i](c, d, e), typeof l == "string" && (!k || g[l] ? l = b : (c.dataTypes.unshift(l), l = bZ(a, c, d, e, l, g))); (k || !l) && !g["*"] && (l = bZ(a, c, d, e, "*", g)); return l } function bY(a) { return function (b, c) { typeof b != "string" && (c = b, b = "*"); if (f.isFunction(c)) { var d = b.toLowerCase().split(bO), e = 0, g = d.length, h, i, j; for (; e < g; e++) h = d[e], j = /^\+/.test(h), j && (h = h.substr(1) || "*"), i = a[h] = a[h] || [], i[j ? "unshift" : "push"](c) } } } function bB(a, b, c) { var d = b === "width" ? a.offsetWidth : a.offsetHeight, e = b === "width" ? 1 : 0, g = 4; if (d > 0) { if (c !== "border") for (; e < g; e += 2) c || (d -= parseFloat(f.css(a, "padding" + bx[e])) || 0), c === "margin" ? d += parseFloat(f.css(a, c + bx[e])) || 0 : d -= parseFloat(f.css(a, "border" + bx[e] + "Width")) || 0; return d + "px" } d = by(a, b); if (d < 0 || d == null) d = a.style[b]; if (bt.test(d)) return d; d = parseFloat(d) || 0; if (c) for (; e < g; e += 2) d += parseFloat(f.css(a, "padding" + bx[e])) || 0, c !== "padding" && (d += parseFloat(f.css(a, "border" + bx[e] + "Width")) || 0), c === "margin" && (d += parseFloat(f.css(a, c + bx[e])) || 0); return d + "px" } function bo(a) { var b = c.createElement("div"); bh.appendChild(b), b.innerHTML = a.outerHTML; return b.firstChild } function bn(a) { var b = (a.nodeName || "").toLowerCase(); b === "input" ? bm(a) : b !== "script" && typeof a.getElementsByTagName != "undefined" && f.grep(a.getElementsByTagName("input"), bm) } function bm(a) { if (a.type === "checkbox" || a.type === "radio") a.defaultChecked = a.checked } function bl(a) { return typeof a.getElementsByTagName != "undefined" ? a.getElementsByTagName("*") : typeof a.querySelectorAll != "undefined" ? a.querySelectorAll("*") : [] } function bk(a, b) { var c; b.nodeType === 1 && (b.clearAttributes && b.clearAttributes(), b.mergeAttributes && b.mergeAttributes(a), c = b.nodeName.toLowerCase(), c === "object" ? b.outerHTML = a.outerHTML : c !== "input" || a.type !== "checkbox" && a.type !== "radio" ? c === "option" ? b.selected = a.defaultSelected : c === "input" || c === "textarea" ? b.defaultValue = a.defaultValue : c === "script" && b.text !== a.text && (b.text = a.text) : (a.checked && (b.defaultChecked = b.checked = a.checked), b.value !== a.value && (b.value = a.value)), b.removeAttribute(f.expando), b.removeAttribute("_submit_attached"), b.removeAttribute("_change_attached")) } function bj(a, b) { if (b.nodeType === 1 && !!f.hasData(a)) { var c, d, e, g = f._data(a), h = f._data(b, g), i = g.events; if (i) { delete h.handle, h.events = {}; for (c in i) for (d = 0, e = i[c].length; d < e; d++) f.event.add(b, c, i[c][d]) } h.data && (h.data = f.extend({}, h.data)) } } function bi(a, b) { return f.nodeName(a, "table") ? a.getElementsByTagName("tbody")[0] || a.appendChild(a.ownerDocument.createElement("tbody")) : a } function U(a) { var b = V.split("|"), c = a.createDocumentFragment(); if (c.createElement) while (b.length) c.createElement(b.pop()); return c } function T(a, b, c) { b = b || 0; if (f.isFunction(b)) return f.grep(a, function (a, d) { var e = !!b.call(a, d, a); return e === c }); if (b.nodeType) return f.grep(a, function (a, d) { return a === b === c }); if (typeof b == "string") { var d = f.grep(a, function (a) { return a.nodeType === 1 }); if (O.test(b)) return f.filter(b, d, !c); b = f.filter(b, d) } return f.grep(a, function (a, d) { return f.inArray(a, b) >= 0 === c }) } function S(a) { return !a || !a.parentNode || a.parentNode.nodeType === 11 } function K() { return !0 } function J() { return !1 } function n(a, b, c) { var d = b + "defer", e = b + "queue", g = b + "mark", h = f._data(a, d); h && (c === "queue" || !f._data(a, e)) && (c === "mark" || !f._data(a, g)) && setTimeout(function () { !f._data(a, e) && !f._data(a, g) && (f.removeData(a, d, !0), h.fire()) }, 0) } function m(a) { for (var b in a) { if (b === "data" && f.isEmptyObject(a[b])) continue; if (b !== "toJSON") return !1 } return !0 } function l(a, c, d) { if (d === b && a.nodeType === 1) { var e = "data-" + c.replace(k, "-$1").toLowerCase(); d = a.getAttribute(e); if (typeof d == "string") { try { d = d === "true" ? !0 : d === "false" ? !1 : d === "null" ? null : f.isNumeric(d) ? +d : j.test(d) ? f.parseJSON(d) : d } catch (g) { } f.data(a, c, d) } else d = b } return d } function h(a) { var b = g[a] = {}, c, d; a = a.split(/\s+/); for (c = 0, d = a.length; c < d; c++) b[a[c]] = !0; return b } var c = a.document, d = a.navigator, e = a.location, f = function () { function J() { if (!e.isReady) { try { c.documentElement.doScroll("left") } catch (a) { setTimeout(J, 1); return } e.ready() } } var e = function (a, b) { return new e.fn.init(a, b, h) }, f = a.jQuery, g = a.$, h, i = /^(?:[^#<]*(<[\w\W]+>)[^>]*$|#([\w\-]*)$)/, j = /\S/, k = /^\s+/, l = /\s+$/, m = /^<(\w+)\s*\/?>(?:<\/\1>)?$/, n = /^[\],:{}\s]*$/, o = /\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, p = /"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, q = /(?:^|:|,)(?:\s*\[)+/g, r = /(webkit)[ \/]([\w.]+)/, s = /(opera)(?:.*version)?[ \/]([\w.]+)/, t = /(msie) ([\w.]+)/, u = /(mozilla)(?:.*? rv:([\w.]+))?/, v = /-([a-z]|[0-9])/ig, w = /^-ms-/, x = function (a, b) { return (b + "").toUpperCase() }, y = d.userAgent, z, A, B, C = Object.prototype.toString, D = Object.prototype.hasOwnProperty, E = Array.prototype.push, F = Array.prototype.slice, G = String.prototype.trim, H = Array.prototype.indexOf, I = {}; e.fn = e.prototype = { constructor: e, init: function (a, d, f) { var g, h, j, k; if (!a) return this; if (a.nodeType) { this.context = this[0] = a, this.length = 1; return this } if (a === "body" && !d && c.body) { this.context = c, this[0] = c.body, this.selector = a, this.length = 1; return this } if (typeof a == "string") { a.charAt(0) !== "<" || a.charAt(a.length - 1) !== ">" || a.length < 3 ? g = i.exec(a) : g = [null, a, null]; if (g && (g[1] || !d)) { if (g[1]) { d = d instanceof e ? d[0] : d, k = d ? d.ownerDocument || d : c, j = m.exec(a), j ? e.isPlainObject(d) ? (a = [c.createElement(j[1])], e.fn.attr.call(a, d, !0)) : a = [k.createElement(j[1])] : (j = e.buildFragment([g[1]], [k]), a = (j.cacheable ? e.clone(j.fragment) : j.fragment).childNodes); return e.merge(this, a) } h = c.getElementById(g[2]); if (h && h.parentNode) { if (h.id !== g[2]) return f.find(a); this.length = 1, this[0] = h } this.context = c, this.selector = a; return this } return !d || d.jquery ? (d || f).find(a) : this.constructor(d).find(a) } if (e.isFunction(a)) return f.ready(a); a.selector !== b && (this.selector = a.selector, this.context = a.context); return e.makeArray(a, this) }, selector: "", jquery: "1.7.2", length: 0, size: function () { return this.length }, toArray: function () { return F.call(this, 0) }, get: function (a) { return a == null ? this.toArray() : a < 0 ? this[this.length + a] : this[a] }, pushStack: function (a, b, c) { var d = this.constructor(); e.isArray(a) ? E.apply(d, a) : e.merge(d, a), d.prevObject = this, d.context = this.context, b === "find" ? d.selector = this.selector + (this.selector ? " " : "") + c : b && (d.selector = this.selector + "." + b + "(" + c + ")"); return d }, each: function (a, b) { return e.each(this, a, b) }, ready: function (a) { e.bindReady(), A.add(a); return this }, eq: function (a) { a = +a; return a === -1 ? this.slice(a) : this.slice(a, a + 1) }, first: function () { return this.eq(0) }, last: function () { return this.eq(-1) }, slice: function () { return this.pushStack(F.apply(this, arguments), "slice", F.call(arguments).join(",")) }, map: function (a) { return this.pushStack(e.map(this, function (b, c) { return a.call(b, c, b) })) }, end: function () { return this.prevObject || this.constructor(null) }, push: E, sort: [].sort, splice: [].splice }, e.fn.init.prototype = e.fn, e.extend = e.fn.extend = function () { var a, c, d, f, g, h, i = arguments[0] || {}, j = 1, k = arguments.length, l = !1; typeof i == "boolean" && (l = i, i = arguments[1] || {}, j = 2), typeof i != "object" && !e.isFunction(i) && (i = {}), k === j && (i = this, --j); for (; j < k; j++) if ((a = arguments[j]) != null) for (c in a) { d = i[c], f = a[c]; if (i === f) continue; l && f && (e.isPlainObject(f) || (g = e.isArray(f))) ? (g ? (g = !1, h = d && e.isArray(d) ? d : []) : h = d && e.isPlainObject(d) ? d : {}, i[c] = e.extend(l, h, f)) : f !== b && (i[c] = f) } return i }, e.extend({ noConflict: function (b) { a.$ === e && (a.$ = g), b && a.jQuery === e && (a.jQuery = f); return e }, isReady: !1, readyWait: 1, holdReady: function (a) { a ? e.readyWait++ : e.ready(!0) }, ready: function (a) { if (a === !0 && !--e.readyWait || a !== !0 && !e.isReady) { if (!c.body) return setTimeout(e.ready, 1); e.isReady = !0; if (a !== !0 && --e.readyWait > 0) return; A.fireWith(c, [e]), e.fn.trigger && e(c).trigger("ready").off("ready") } }, bindReady: function () { if (!A) { A = e.Callbacks("once memory"); if (c.readyState === "complete") return setTimeout(e.ready, 1); if (c.addEventListener) c.addEventListener("DOMContentLoaded", B, !1), a.addEventListener("load", e.ready, !1); else if (c.attachEvent) { c.attachEvent("onreadystatechange", B), a.attachEvent("onload", e.ready); var b = !1; try { b = a.frameElement == null } catch (d) { } c.documentElement.doScroll && b && J() } } }, isFunction: function (a) { return e.type(a) === "function" }, isArray: Array.isArray || function (a) { return e.type(a) === "array" }, isWindow: function (a) { return a != null && a == a.window }, isNumeric: function (a) { return !isNaN(parseFloat(a)) && isFinite(a) }, type: function (a) { return a == null ? String(a) : I[C.call(a)] || "object" }, isPlainObject: function (a) { if (!a || e.type(a) !== "object" || a.nodeType || e.isWindow(a)) return !1; try { if (a.constructor && !D.call(a, "constructor") && !D.call(a.constructor.prototype, "isPrototypeOf")) return !1 } catch (c) { return !1 } var d; for (d in a); return d === b || D.call(a, d) }, isEmptyObject: function (a) { for (var b in a) return !1; return !0 }, error: function (a) { throw new Error(a) }, parseJSON: function (b) { if (typeof b != "string" || !b) return null; b = e.trim(b); if (a.JSON && a.JSON.parse) return a.JSON.parse(b); if (n.test(b.replace(o, "@").replace(p, "]").replace(q, ""))) return (new Function("return " + b))(); e.error("Invalid JSON: " + b) }, parseXML: function (c) { if (typeof c != "string" || !c) return null; var d, f; try { a.DOMParser ? (f = new DOMParser, d = f.parseFromString(c, "text/xml")) : (d = new ActiveXObject("Microsoft.XMLDOM"), d.async = "false", d.loadXML(c)) } catch (g) { d = b } (!d || !d.documentElement || d.getElementsByTagName("parsererror").length) && e.error("Invalid XML: " + c); return d }, noop: function () { }, globalEval: function (b) { b && j.test(b) && (a.execScript || function (b) { a.eval.call(a, b) })(b) }, camelCase: function (a) { return a.replace(w, "ms-").replace(v, x) }, nodeName: function (a, b) { return a.nodeName && a.nodeName.toUpperCase() === b.toUpperCase() }, each: function (a, c, d) { var f, g = 0, h = a.length, i = h === b || e.isFunction(a); if (d) { if (i) { for (f in a) if (c.apply(a[f], d) === !1) break } else for (; g < h;) if (c.apply(a[g++], d) === !1) break } else if (i) { for (f in a) if (c.call(a[f], f, a[f]) === !1) break } else for (; g < h;) if (c.call(a[g], g, a[g++]) === !1) break; return a }, trim: G ? function (a) { return a == null ? "" : G.call(a) } : function (a) { return a == null ? "" : (a + "").replace(k, "").replace(l, "") }, makeArray: function (a, b) { var c = b || []; if (a != null) { var d = e.type(a); a.length == null || d === "string" || d === "function" || d === "regexp" || e.isWindow(a) ? E.call(c, a) : e.merge(c, a) } return c }, inArray: function (a, b, c) { var d; if (b) { if (H) return H.call(b, a, c); d = b.length, c = c ? c < 0 ? Math.max(0, d + c) : c : 0; for (; c < d; c++) if (c in b && b[c] === a) return c } return -1 }, merge: function (a, c) { var d = a.length, e = 0; if (typeof c.length == "number") for (var f = c.length; e < f; e++) a[d++] = c[e]; else while (c[e] !== b) a[d++] = c[e++]; a.length = d; return a }, grep: function (a, b, c) { var d = [], e; c = !!c; for (var f = 0, g = a.length; f < g; f++) e = !!b(a[f], f), c !== e && d.push(a[f]); return d }, map: function (a, c, d) { var f, g, h = [], i = 0, j = a.length, k = a instanceof e || j !== b && typeof j == "number" && (j > 0 && a[0] && a[j - 1] || j === 0 || e.isArray(a)); if (k) for (; i < j; i++) f = c(a[i], i, d), f != null && (h[h.length] = f); else for (g in a) f = c(a[g], g, d), f != null && (h[h.length] = f); return h.concat.apply([], h) }, guid: 1, proxy: function (a, c) { if (typeof c == "string") { var d = a[c]; c = a, a = d } if (!e.isFunction(a)) return b; var f = F.call(arguments, 2), g = function () { return a.apply(c, f.concat(F.call(arguments))) }; g.guid = a.guid = a.guid || g.guid || e.guid++; return g }, access: function (a, c, d, f, g, h, i) { var j, k = d == null, l = 0, m = a.length; if (d && typeof d == "object") { for (l in d) e.access(a, c, l, d[l], 1, h, f); g = 1 } else if (f !== b) { j = i === b && e.isFunction(f), k && (j ? (j = c, c = function (a, b, c) { return j.call(e(a), c) }) : (c.call(a, f), c = null)); if (c) for (; l < m; l++) c(a[l], d, j ? f.call(a[l], l, c(a[l], d)) : f, i); g = 1 } return g ? a : k ? c.call(a) : m ? c(a[0], d) : h }, now: function () { return (new Date).getTime() }, uaMatch: function (a) { a = a.toLowerCase(); var b = r.exec(a) || s.exec(a) || t.exec(a) || a.indexOf("compatible") < 0 && u.exec(a) || []; return { browser: b[1] || "", version: b[2] || "0" } }, sub: function () { function a(b, c) { return new a.fn.init(b, c) } e.extend(!0, a, this), a.superclass = this, a.fn = a.prototype = this(), a.fn.constructor = a, a.sub = this.sub, a.fn.init = function (d, f) { f && f instanceof e && !(f instanceof a) && (f = a(f)); return e.fn.init.call(this, d, f, b) }, a.fn.init.prototype = a.fn; var b = a(c); return a }, browser: {} }), e.each("Boolean Number String Function Array Date RegExp Object".split(" "), function (a, b) { I["[object " + b + "]"] = b.toLowerCase() }), z = e.uaMatch(y), z.browser && (e.browser[z.browser] = !0, e.browser.version = z.version), e.browser.webkit && (e.browser.safari = !0), j.test(" ") && (k = /^[\s\xA0]+/, l = /[\s\xA0]+$/), h = e(c), c.addEventListener ? B = function () { c.removeEventListener("DOMContentLoaded", B, !1), e.ready() } : c.attachEvent && (B = function () { c.readyState === "complete" && (c.detachEvent("onreadystatechange", B), e.ready()) }); return e }(), g = {}; f.Callbacks = function (a) { a = a ? g[a] || h(a) : {}; var c = [], d = [], e, i, j, k, l, m, n = function (b) { var d, e, g, h, i; for (d = 0, e = b.length; d < e; d++) g = b[d], h = f.type(g), h === "array" ? n(g) : h === "function" && (!a.unique || !p.has(g)) && c.push(g) }, o = function (b, f) { f = f || [], e = !a.memory || [b, f], i = !0, j = !0, m = k || 0, k = 0, l = c.length; for (; c && m < l; m++) if (c[m].apply(b, f) === !1 && a.stopOnFalse) { e = !0; break } j = !1, c && (a.once ? e === !0 ? p.disable() : c = [] : d && d.length && (e = d.shift(), p.fireWith(e[0], e[1]))) }, p = { add: function () { if (c) { var a = c.length; n(arguments), j ? l = c.length : e && e !== !0 && (k = a, o(e[0], e[1])) } return this }, remove: function () { if (c) { var b = arguments, d = 0, e = b.length; for (; d < e; d++) for (var f = 0; f < c.length; f++) if (b[d] === c[f]) { j && f <= l && (l--, f <= m && m--), c.splice(f--, 1); if (a.unique) break } } return this }, has: function (a) { if (c) { var b = 0, d = c.length; for (; b < d; b++) if (a === c[b]) return !0 } return !1 }, empty: function () { c = []; return this }, disable: function () { c = d = e = b; return this }, disabled: function () { return !c }, lock: function () { d = b, (!e || e === !0) && p.disable(); return this }, locked: function () { return !d }, fireWith: function (b, c) { d && (j ? a.once || d.push([b, c]) : (!a.once || !e) && o(b, c)); return this }, fire: function () { p.fireWith(this, arguments); return this }, fired: function () { return !!i } }; return p }; var i = [].slice; f.extend({ Deferred: function (a) { var b = f.Callbacks("once memory"), c = f.Callbacks("once memory"), d = f.Callbacks("memory"), e = "pending", g = { resolve: b, reject: c, notify: d }, h = { done: b.add, fail: c.add, progress: d.add, state: function () { return e }, isResolved: b.fired, isRejected: c.fired, then: function (a, b, c) { i.done(a).fail(b).progress(c); return this }, always: function () { i.done.apply(i, arguments).fail.apply(i, arguments); return this }, pipe: function (a, b, c) { return f.Deferred(function (d) { f.each({ done: [a, "resolve"], fail: [b, "reject"], progress: [c, "notify"] }, function (a, b) { var c = b[0], e = b[1], g; f.isFunction(c) ? i[a](function () { g = c.apply(this, arguments), g && f.isFunction(g.promise) ? g.promise().then(d.resolve, d.reject, d.notify) : d[e + "With"](this === i ? d : this, [g]) }) : i[a](d[e]) }) }).promise() }, promise: function (a) { if (a == null) a = h; else for (var b in h) a[b] = h[b]; return a } }, i = h.promise({}), j; for (j in g) i[j] = g[j].fire, i[j + "With"] = g[j].fireWith; i.done(function () { e = "resolved" }, c.disable, d.lock).fail(function () { e = "rejected" }, b.disable, d.lock), a && a.call(i, i); return i }, when: function (a) { function m(a) { return function (b) { e[a] = arguments.length > 1 ? i.call(arguments, 0) : b, j.notifyWith(k, e) } } function l(a) { return function (c) { b[a] = arguments.length > 1 ? i.call(arguments, 0) : c, --g || j.resolveWith(j, b) } } var b = i.call(arguments, 0), c = 0, d = b.length, e = Array(d), g = d, h = d, j = d <= 1 && a && f.isFunction(a.promise) ? a : f.Deferred(), k = j.promise(); if (d > 1) { for (; c < d; c++) b[c] && b[c].promise && f.isFunction(b[c].promise) ? b[c].promise().then(l(c), j.reject, m(c)) : --g; g || j.resolveWith(j, b) } else j !== a && j.resolveWith(j, d ? [a] : []); return k } }), f.support = function () { var b, d, e, g, h, i, j, k, l, m, n, o, p = c.createElement("div"), q = c.documentElement; p.setAttribute("className", "t"), p.innerHTML = "   <link/><table></table><a href='/a' style='top:1px;float:left;opacity:.55;'>a</a><input type='checkbox'/>", d = p.getElementsByTagName("*"), e = p.getElementsByTagName("a")[0]; if (!d || !d.length || !e) return {}; g = c.createElement("select"), h = g.appendChild(c.createElement("option")), i = p.getElementsByTagName("input")[0], b = { leadingWhitespace: p.firstChild.nodeType === 3, tbody: !p.getElementsByTagName("tbody").length, htmlSerialize: !!p.getElementsByTagName("link").length, style: /top/.test(e.getAttribute("style")), hrefNormalized: e.getAttribute("href") === "/a", opacity: /^0.55/.test(e.style.opacity), cssFloat: !!e.style.cssFloat, checkOn: i.value === "on", optSelected: h.selected, getSetAttribute: p.className !== "t", enctype: !!c.createElement("form").enctype, html5Clone: c.createElement("nav").cloneNode(!0).outerHTML !== "<:nav></:nav>", submitBubbles: !0, changeBubbles: !0, focusinBubbles: !1, deleteExpando: !0, noCloneEvent: !0, inlineBlockNeedsLayout: !1, shrinkWrapBlocks: !1, reliableMarginRight: !0, pixelMargin: !0 }, f.boxModel = b.boxModel = c.compatMode === "CSS1Compat", i.checked = !0, b.noCloneChecked = i.cloneNode(!0).checked, g.disabled = !0, b.optDisabled = !h.disabled; try { delete p.test } catch (r) { b.deleteExpando = !1 } !p.addEventListener && p.attachEvent && p.fireEvent && (p.attachEvent("onclick", function () { b.noCloneEvent = !1 }), p.cloneNode(!0).fireEvent("onclick")), i = c.createElement("input"), i.value = "t", i.setAttribute("type", "radio"), b.radioValue = i.value === "t", i.setAttribute("checked", "checked"), i.setAttribute("name", "t"), p.appendChild(i), j = c.createDocumentFragment(), j.appendChild(p.lastChild), b.checkClone = j.cloneNode(!0).cloneNode(!0).lastChild.checked, b.appendChecked = i.checked, j.removeChild(i), j.appendChild(p); if (p.attachEvent) for (n in { submit: 1, change: 1, focusin: 1 }) m = "on" + n, o = m in p, o || (p.setAttribute(m, "return;"), o = typeof p[m] == "function"), b[n + "Bubbles"] = o; j.removeChild(p), j = g = h = p = i = null, f(function () { var d, e, g, h, i, j, l, m, n, q, r, s, t, u = c.getElementsByTagName("body")[0]; !u || (m = 1, t = "padding:0;margin:0;border:", r = "position:absolute;top:0;left:0;width:1px;height:1px;", s = t + "0;visibility:hidden;", n = "style='" + r + t + "5px solid #524570;", q = "<div " + n + "display:block;'><div style='" + t + "0;display:block;overflow:hidden;'></div></div>" + "<table " + n + "' cellpadding='0' cellspacing='0'>" + "<tr><td></td></tr></table>", d = c.createElement("div"), d.style.cssText = s + "width:0;height:0;position:static;top:0;margin-top:" + m + "px", u.insertBefore(d, u.firstChild), p = c.createElement("div"), d.appendChild(p), p.innerHTML = "<table><tr><td style='" + t + "0;display:none'></td><td>t</td></tr></table>", k = p.getElementsByTagName("td"), o = k[0].offsetHeight === 0, k[0].style.display = "", k[1].style.display = "none", b.reliableHiddenOffsets = o && k[0].offsetHeight === 0, a.getComputedStyle && (p.innerHTML = "", l = c.createElement("div"), l.style.width = "0", l.style.marginRight = "0", p.style.width = "2px", p.appendChild(l), b.reliableMarginRight = (parseInt((a.getComputedStyle(l, null) || { marginRight: 0 }).marginRight, 10) || 0) === 0), typeof p.style.zoom != "undefined" && (p.innerHTML = "", p.style.width = p.style.padding = "1px", p.style.border = 0, p.style.overflow = "hidden", p.style.display = "inline", p.style.zoom = 1, b.inlineBlockNeedsLayout = p.offsetWidth === 3, p.style.display = "block", p.style.overflow = "visible", p.innerHTML = "<div style='width:5px;'></div>", b.shrinkWrapBlocks = p.offsetWidth !== 3), p.style.cssText = r + s, p.innerHTML = q, e = p.firstChild, g = e.firstChild, i = e.nextSibling.firstChild.firstChild, j = { doesNotAddBorder: g.offsetTop !== 5, doesAddBorderForTableAndCells: i.offsetTop === 5 }, g.style.position = "fixed", g.style.top = "20px", j.fixedPosition = g.offsetTop === 20 || g.offsetTop === 15, g.style.position = g.style.top = "", e.style.overflow = "hidden", e.style.position = "relative", j.subtractsBorderForOverflowNotVisible = g.offsetTop === -5, j.doesNotIncludeMarginInBodyOffset = u.offsetTop !== m, a.getComputedStyle && (p.style.marginTop = "1%", b.pixelMargin = (a.getComputedStyle(p, null) || { marginTop: 0 }).marginTop !== "1%"), typeof d.style.zoom != "undefined" && (d.style.zoom = 1), u.removeChild(d), l = p = d = null, f.extend(b, j)) }); return b }(); var j = /^(?:\{.*\}|\[.*\])$/, k = /([A-Z])/g; f.extend({ cache: {}, uuid: 0, expando: "jQuery" + (f.fn.jquery + Math.random()).replace(/\D/g, ""), noData: { embed: !0, object: "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000", applet: !0 }, hasData: function (a) { a = a.nodeType ? f.cache[a[f.expando]] : a[f.expando]; return !!a && !m(a) }, data: function (a, c, d, e) { if (!!f.acceptData(a)) { var g, h, i, j = f.expando, k = typeof c == "string", l = a.nodeType, m = l ? f.cache : a, n = l ? a[j] : a[j] && j, o = c === "events"; if ((!n || !m[n] || !o && !e && !m[n].data) && k && d === b) return; n || (l ? a[j] = n = ++f.uuid : n = j), m[n] || (m[n] = {}, l || (m[n].toJSON = f.noop)); if (typeof c == "object" || typeof c == "function") e ? m[n] = f.extend(m[n], c) : m[n].data = f.extend(m[n].data, c); g = h = m[n], e || (h.data || (h.data = {}), h = h.data), d !== b && (h[f.camelCase(c)] = d); if (o && !h[c]) return g.events; k ? (i = h[c], i == null && (i = h[f.camelCase(c)])) : i = h; return i } }, removeData: function (a, b, c) { if (!!f.acceptData(a)) { var d, e, g, h = f.expando, i = a.nodeType, j = i ? f.cache : a, k = i ? a[h] : h; if (!j[k]) return; if (b) { d = c ? j[k] : j[k].data; if (d) { f.isArray(b) || (b in d ? b = [b] : (b = f.camelCase(b), b in d ? b = [b] : b = b.split(" "))); for (e = 0, g = b.length; e < g; e++) delete d[b[e]]; if (!(c ? m : f.isEmptyObject)(d)) return } } if (!c) { delete j[k].data; if (!m(j[k])) return } f.support.deleteExpando || !j.setInterval ? delete j[k] : j[k] = null, i && (f.support.deleteExpando ? delete a[h] : a.removeAttribute ? a.removeAttribute(h) : a[h] = null) } }, _data: function (a, b, c) { return f.data(a, b, c, !0) }, acceptData: function (a) { if (a.nodeName) { var b = f.noData[a.nodeName.toLowerCase()]; if (b) return b !== !0 && a.getAttribute("classid") === b } return !0 } }), f.fn.extend({ data: function (a, c) { var d, e, g, h, i, j = this[0], k = 0, m = null; if (a === b) { if (this.length) { m = f.data(j); if (j.nodeType === 1 && !f._data(j, "parsedAttrs")) { g = j.attributes; for (i = g.length; k < i; k++) h = g[k].name, h.indexOf("data-") === 0 && (h = f.camelCase(h.substring(5)), l(j, h, m[h])); f._data(j, "parsedAttrs", !0) } } return m } if (typeof a == "object") return this.each(function () { f.data(this, a) }); d = a.split(".", 2), d[1] = d[1] ? "." + d[1] : "", e = d[1] + "!"; return f.access(this, function (c) { if (c === b) { m = this.triggerHandler("getData" + e, [d[0]]), m === b && j && (m = f.data(j, a), m = l(j, a, m)); return m === b && d[1] ? this.data(d[0]) : m } d[1] = c, this.each(function () { var b = f(this); b.triggerHandler("setData" + e, d), f.data(this, a, c), b.triggerHandler("changeData" + e, d) }) }, null, c, arguments.length > 1, null, !1) }, removeData: function (a) { return this.each(function () { f.removeData(this, a) }) } }), f.extend({ _mark: function (a, b) { a && (b = (b || "fx") + "mark", f._data(a, b, (f._data(a, b) || 0) + 1)) }, _unmark: function (a, b, c) { a !== !0 && (c = b, b = a, a = !1); if (b) { c = c || "fx"; var d = c + "mark", e = a ? 0 : (f._data(b, d) || 1) - 1; e ? f._data(b, d, e) : (f.removeData(b, d, !0), n(b, c, "mark")) } }, queue: function (a, b, c) { var d; if (a) { b = (b || "fx") + "queue", d = f._data(a, b), c && (!d || f.isArray(c) ? d = f._data(a, b, f.makeArray(c)) : d.push(c)); return d || [] } }, dequeue: function (a, b) { b = b || "fx"; var c = f.queue(a, b), d = c.shift(), e = {}; d === "inprogress" && (d = c.shift()), d && (b === "fx" && c.unshift("inprogress"), f._data(a, b + ".run", e), d.call(a, function () { f.dequeue(a, b) }, e)), c.length || (f.removeData(a, b + "queue " + b + ".run", !0), n(a, b, "queue")) } }), f.fn.extend({ queue: function (a, c) { var d = 2; typeof a != "string" && (c = a, a = "fx", d--); if (arguments.length < d) return f.queue(this[0], a); return c === b ? this : this.each(function () { var b = f.queue(this, a, c); a === "fx" && b[0] !== "inprogress" && f.dequeue(this, a) }) }, dequeue: function (a) { return this.each(function () { f.dequeue(this, a) }) }, delay: function (a, b) { a = f.fx ? f.fx.speeds[a] || a : a, b = b || "fx"; return this.queue(b, function (b, c) { var d = setTimeout(b, a); c.stop = function () { clearTimeout(d) } }) }, clearQueue: function (a) { return this.queue(a || "fx", []) }, promise: function (a, c) { function m() { --h || d.resolveWith(e, [e]) } typeof a != "string" && (c = a, a = b), a = a || "fx"; var d = f.Deferred(), e = this, g = e.length, h = 1, i = a + "defer", j = a + "queue", k = a + "mark", l; while (g--) if (l = f.data(e[g], i, b, !0) || (f.data(e[g], j, b, !0) || f.data(e[g], k, b, !0)) && f.data(e[g], i, f.Callbacks("once memory"), !0)) h++, l.add(m); m(); return d.promise(c) } }); var o = /[\n\t\r]/g, p = /\s+/, q = /\r/g, r = /^(?:button|input)$/i, s = /^(?:button|input|object|select|textarea)$/i, t = /^a(?:rea)?$/i, u = /^(?:autofocus|autoplay|async|checked|controls|defer|disabled|hidden|loop|multiple|open|readonly|required|scoped|selected)$/i, v = f.support.getSetAttribute, w, x, y; f.fn.extend({ attr: function (a, b) { return f.access(this, f.attr, a, b, arguments.length > 1) }, removeAttr: function (a) { return this.each(function () { f.removeAttr(this, a) }) }, prop: function (a, b) { return f.access(this, f.prop, a, b, arguments.length > 1) }, removeProp: function (a) { a = f.propFix[a] || a; return this.each(function () { try { this[a] = b, delete this[a] } catch (c) { } }) }, addClass: function (a) { var b, c, d, e, g, h, i; if (f.isFunction(a)) return this.each(function (b) { f(this).addClass(a.call(this, b, this.className)) }); if (a && typeof a == "string") { b = a.split(p); for (c = 0, d = this.length; c < d; c++) { e = this[c]; if (e.nodeType === 1) if (!e.className && b.length === 1) e.className = a; else { g = " " + e.className + " "; for (h = 0, i = b.length; h < i; h++) ~g.indexOf(" " + b[h] + " ") || (g += b[h] + " "); e.className = f.trim(g) } } } return this }, removeClass: function (a) { var c, d, e, g, h, i, j; if (f.isFunction(a)) return this.each(function (b) { f(this).removeClass(a.call(this, b, this.className)) }); if (a && typeof a == "string" || a === b) { c = (a || "").split(p); for (d = 0, e = this.length; d < e; d++) { g = this[d]; if (g.nodeType === 1 && g.className) if (a) { h = (" " + g.className + " ").replace(o, " "); for (i = 0, j = c.length; i < j; i++) h = h.replace(" " + c[i] + " ", " "); g.className = f.trim(h) } else g.className = "" } } return this }, toggleClass: function (a, b) { var c = typeof a, d = typeof b == "boolean"; if (f.isFunction(a)) return this.each(function (c) { f(this).toggleClass(a.call(this, c, this.className, b), b) }); return this.each(function () { if (c === "string") { var e, g = 0, h = f(this), i = b, j = a.split(p); while (e = j[g++]) i = d ? i : !h.hasClass(e), h[i ? "addClass" : "removeClass"](e) } else if (c === "undefined" || c === "boolean") this.className && f._data(this, "__className__", this.className), this.className = this.className || a === !1 ? "" : f._data(this, "__className__") || "" }) }, hasClass: function (a) { var b = " " + a + " ", c = 0, d = this.length; for (; c < d; c++) if (this[c].nodeType === 1 && (" " + this[c].className + " ").replace(o, " ").indexOf(b) > -1) return !0; return !1 }, val: function (a) { var c, d, e, g = this[0]; { if (!!arguments.length) { e = f.isFunction(a); return this.each(function (d) { var g = f(this), h; if (this.nodeType === 1) { e ? h = a.call(this, d, g.val()) : h = a, h == null ? h = "" : typeof h == "number" ? h += "" : f.isArray(h) && (h = f.map(h, function (a) { return a == null ? "" : a + "" })), c = f.valHooks[this.type] || f.valHooks[this.nodeName.toLowerCase()]; if (!c || !("set" in c) || c.set(this, h, "value") === b) this.value = h } }) } if (g) { c = f.valHooks[g.type] || f.valHooks[g.nodeName.toLowerCase()]; if (c && "get" in c && (d = c.get(g, "value")) !== b) return d; d = g.value; return typeof d == "string" ? d.replace(q, "") : d == null ? "" : d } } } }), f.extend({ valHooks: { option: { get: function (a) { var b = a.attributes.value; return !b || b.specified ? a.value : a.text } }, select: { get: function (a) { var b, c, d, e, g = a.selectedIndex, h = [], i = a.options, j = a.type === "select-one"; if (g < 0) return null; c = j ? g : 0, d = j ? g + 1 : i.length; for (; c < d; c++) { e = i[c]; if (e.selected && (f.support.optDisabled ? !e.disabled : e.getAttribute("disabled") === null) && (!e.parentNode.disabled || !f.nodeName(e.parentNode, "optgroup"))) { b = f(e).val(); if (j) return b; h.push(b) } } if (j && !h.length && i.length) return f(i[g]).val(); return h }, set: function (a, b) { var c = f.makeArray(b); f(a).find("option").each(function () { this.selected = f.inArray(f(this).val(), c) >= 0 }), c.length || (a.selectedIndex = -1); return c } } }, attrFn: { val: !0, css: !0, html: !0, text: !0, data: !0, width: !0, height: !0, offset: !0 }, attr: function (a, c, d, e) { var g, h, i, j = a.nodeType; if (!!a && j !== 3 && j !== 8 && j !== 2) { if (e && c in f.attrFn) return f(a)[c](d); if (typeof a.getAttribute == "undefined") return f.prop(a, c, d); i = j !== 1 || !f.isXMLDoc(a), i && (c = c.toLowerCase(), h = f.attrHooks[c] || (u.test(c) ? x : w)); if (d !== b) { if (d === null) { f.removeAttr(a, c); return } if (h && "set" in h && i && (g = h.set(a, d, c)) !== b) return g; a.setAttribute(c, "" + d); return d } if (h && "get" in h && i && (g = h.get(a, c)) !== null) return g; g = a.getAttribute(c); return g === null ? b : g } }, removeAttr: function (a, b) { var c, d, e, g, h, i = 0; if (b && a.nodeType === 1) { d = b.toLowerCase().split(p), g = d.length; for (; i < g; i++) e = d[i], e && (c = f.propFix[e] || e, h = u.test(e), h || f.attr(a, e, ""), a.removeAttribute(v ? e : c), h && c in a && (a[c] = !1)) } }, attrHooks: { type: { set: function (a, b) { if (r.test(a.nodeName) && a.parentNode) f.error("type property can't be changed"); else if (!f.support.radioValue && b === "radio" && f.nodeName(a, "input")) { var c = a.value; a.setAttribute("type", b), c && (a.value = c); return b } } }, value: { get: function (a, b) { if (w && f.nodeName(a, "button")) return w.get(a, b); return b in a ? a.value : null }, set: function (a, b, c) { if (w && f.nodeName(a, "button")) return w.set(a, b, c); a.value = b } } }, propFix: { tabindex: "tabIndex", readonly: "readOnly", "for": "htmlFor", "class": "className", maxlength: "maxLength", cellspacing: "cellSpacing", cellpadding: "cellPadding", rowspan: "rowSpan", colspan: "colSpan", usemap: "useMap", frameborder: "frameBorder", contenteditable: "contentEditable" }, prop: function (a, c, d) { var e, g, h, i = a.nodeType; if (!!a && i !== 3 && i !== 8 && i !== 2) { h = i !== 1 || !f.isXMLDoc(a), h && (c = f.propFix[c] || c, g = f.propHooks[c]); return d !== b ? g && "set" in g && (e = g.set(a, d, c)) !== b ? e : a[c] = d : g && "get" in g && (e = g.get(a, c)) !== null ? e : a[c] } }, propHooks: { tabIndex: { get: function (a) { var c = a.getAttributeNode("tabindex"); return c && c.specified ? parseInt(c.value, 10) : s.test(a.nodeName) || t.test(a.nodeName) && a.href ? 0 : b } } } }), f.attrHooks.tabindex = f.propHooks.tabIndex, x = { get: function (a, c) { var d, e = f.prop(a, c); return e === !0 || typeof e != "boolean" && (d = a.getAttributeNode(c)) && d.nodeValue !== !1 ? c.toLowerCase() : b }, set: function (a, b, c) { var d; b === !1 ? f.removeAttr(a, c) : (d = f.propFix[c] || c, d in a && (a[d] = !0), a.setAttribute(c, c.toLowerCase())); return c } }, v || (y = { name: !0, id: !0, coords: !0 }, w = f.valHooks.button = { get: function (a, c) { var d; d = a.getAttributeNode(c); return d && (y[c] ? d.nodeValue !== "" : d.specified) ? d.nodeValue : b }, set: function (a, b, d) { var e = a.getAttributeNode(d); e || (e = c.createAttribute(d), a.setAttributeNode(e)); return e.nodeValue = b + "" } }, f.attrHooks.tabindex.set = w.set, f.each(["width", "height"], function (a, b) { f.attrHooks[b] = f.extend(f.attrHooks[b], { set: function (a, c) { if (c === "") { a.setAttribute(b, "auto"); return c } } }) }), f.attrHooks.contenteditable = { get: w.get, set: function (a, b, c) { b === "" && (b = "false"), w.set(a, b, c) } }), f.support.hrefNormalized || f.each(["href", "src", "width", "height"], function (a, c) { f.attrHooks[c] = f.extend(f.attrHooks[c], { get: function (a) { var d = a.getAttribute(c, 2); return d === null ? b : d } }) }), f.support.style || (f.attrHooks.style = { get: function (a) { return a.style.cssText.toLowerCase() || b }, set: function (a, b) { return a.style.cssText = "" + b } }), f.support.optSelected || (f.propHooks.selected = f.extend(f.propHooks.selected, { get: function (a) { var b = a.parentNode; b && (b.selectedIndex, b.parentNode && b.parentNode.selectedIndex); return null } })), f.support.enctype || (f.propFix.enctype = "encoding"), f.support.checkOn || f.each(["radio", "checkbox"], function () { f.valHooks[this] = { get: function (a) { return a.getAttribute("value") === null ? "on" : a.value } } }), f.each(["radio", "checkbox"], function () { f.valHooks[this] = f.extend(f.valHooks[this], { set: function (a, b) { if (f.isArray(b)) return a.checked = f.inArray(f(a).val(), b) >= 0 } }) }); var z = /^(?:textarea|input|select)$/i, A = /^([^\.]*)?(?:\.(.+))?$/, B = /(?:^|\s)hover(\.\S+)?\b/, C = /^key/, D = /^(?:mouse|contextmenu)|click/, E = /^(?:focusinfocus|focusoutblur)$/, F = /^(\w*)(?:#([\w\-]+))?(?:\.([\w\-]+))?$/, G = function (
    a) { var b = F.exec(a); b && (b[1] = (b[1] || "").toLowerCase(), b[3] = b[3] && new RegExp("(?:^|\\s)" + b[3] + "(?:\\s|$)")); return b }, H = function (a, b) { var c = a.attributes || {}; return (!b[1] || a.nodeName.toLowerCase() === b[1]) && (!b[2] || (c.id || {}).value === b[2]) && (!b[3] || b[3].test((c["class"] || {}).value)) }, I = function (a) { return f.event.special.hover ? a : a.replace(B, "mouseenter$1 mouseleave$1") }; f.event = { add: function (a, c, d, e, g) { var h, i, j, k, l, m, n, o, p, q, r, s; if (!(a.nodeType === 3 || a.nodeType === 8 || !c || !d || !(h = f._data(a)))) { d.handler && (p = d, d = p.handler, g = p.selector), d.guid || (d.guid = f.guid++), j = h.events, j || (h.events = j = {}), i = h.handle, i || (h.handle = i = function (a) { return typeof f != "undefined" && (!a || f.event.triggered !== a.type) ? f.event.dispatch.apply(i.elem, arguments) : b }, i.elem = a), c = f.trim(I(c)).split(" "); for (k = 0; k < c.length; k++) { l = A.exec(c[k]) || [], m = l[1], n = (l[2] || "").split(".").sort(), s = f.event.special[m] || {}, m = (g ? s.delegateType : s.bindType) || m, s = f.event.special[m] || {}, o = f.extend({ type: m, origType: l[1], data: e, handler: d, guid: d.guid, selector: g, quick: g && G(g), namespace: n.join(".") }, p), r = j[m]; if (!r) { r = j[m] = [], r.delegateCount = 0; if (!s.setup || s.setup.call(a, e, n, i) === !1) a.addEventListener ? a.addEventListener(m, i, !1) : a.attachEvent && a.attachEvent("on" + m, i) } s.add && (s.add.call(a, o), o.handler.guid || (o.handler.guid = d.guid)), g ? r.splice(r.delegateCount++, 0, o) : r.push(o), f.event.global[m] = !0 } a = null } }, global: {}, remove: function (a, b, c, d, e) { var g = f.hasData(a) && f._data(a), h, i, j, k, l, m, n, o, p, q, r, s; if (!!g && !!(o = g.events)) { b = f.trim(I(b || "")).split(" "); for (h = 0; h < b.length; h++) { i = A.exec(b[h]) || [], j = k = i[1], l = i[2]; if (!j) { for (j in o) f.event.remove(a, j + b[h], c, d, !0); continue } p = f.event.special[j] || {}, j = (d ? p.delegateType : p.bindType) || j, r = o[j] || [], m = r.length, l = l ? new RegExp("(^|\\.)" + l.split(".").sort().join("\\.(?:.*\\.)?") + "(\\.|$)") : null; for (n = 0; n < r.length; n++) s = r[n], (e || k === s.origType) && (!c || c.guid === s.guid) && (!l || l.test(s.namespace)) && (!d || d === s.selector || d === "**" && s.selector) && (r.splice(n--, 1), s.selector && r.delegateCount--, p.remove && p.remove.call(a, s)); r.length === 0 && m !== r.length && ((!p.teardown || p.teardown.call(a, l) === !1) && f.removeEvent(a, j, g.handle), delete o[j]) } f.isEmptyObject(o) && (q = g.handle, q && (q.elem = null), f.removeData(a, ["events", "handle"], !0)) } }, customEvent: { getData: !0, setData: !0, changeData: !0 }, trigger: function (c, d, e, g) { if (!e || e.nodeType !== 3 && e.nodeType !== 8) { var h = c.type || c, i = [], j, k, l, m, n, o, p, q, r, s; if (E.test(h + f.event.triggered)) return; h.indexOf("!") >= 0 && (h = h.slice(0, -1), k = !0), h.indexOf(".") >= 0 && (i = h.split("."), h = i.shift(), i.sort()); if ((!e || f.event.customEvent[h]) && !f.event.global[h]) return; c = typeof c == "object" ? c[f.expando] ? c : new f.Event(h, c) : new f.Event(h), c.type = h, c.isTrigger = !0, c.exclusive = k, c.namespace = i.join("."), c.namespace_re = c.namespace ? new RegExp("(^|\\.)" + i.join("\\.(?:.*\\.)?") + "(\\.|$)") : null, o = h.indexOf(":") < 0 ? "on" + h : ""; if (!e) { j = f.cache; for (l in j) j[l].events && j[l].events[h] && f.event.trigger(c, d, j[l].handle.elem, !0); return } c.result = b, c.target || (c.target = e), d = d != null ? f.makeArray(d) : [], d.unshift(c), p = f.event.special[h] || {}; if (p.trigger && p.trigger.apply(e, d) === !1) return; r = [[e, p.bindType || h]]; if (!g && !p.noBubble && !f.isWindow(e)) { s = p.delegateType || h, m = E.test(s + h) ? e : e.parentNode, n = null; for (; m; m = m.parentNode) r.push([m, s]), n = m; n && n === e.ownerDocument && r.push([n.defaultView || n.parentWindow || a, s]) } for (l = 0; l < r.length && !c.isPropagationStopped() ; l++) m = r[l][0], c.type = r[l][1], q = (f._data(m, "events") || {})[c.type] && f._data(m, "handle"), q && q.apply(m, d), q = o && m[o], q && f.acceptData(m) && q.apply(m, d) === !1 && c.preventDefault(); c.type = h, !g && !c.isDefaultPrevented() && (!p._default || p._default.apply(e.ownerDocument, d) === !1) && (h !== "click" || !f.nodeName(e, "a")) && f.acceptData(e) && o && e[h] && (h !== "focus" && h !== "blur" || c.target.offsetWidth !== 0) && !f.isWindow(e) && (n = e[o], n && (e[o] = null), f.event.triggered = h, e[h](), f.event.triggered = b, n && (e[o] = n)); return c.result } }, dispatch: function (c) { c = f.event.fix(c || a.event); var d = (f._data(this, "events") || {})[c.type] || [], e = d.delegateCount, g = [].slice.call(arguments, 0), h = !c.exclusive && !c.namespace, i = f.event.special[c.type] || {}, j = [], k, l, m, n, o, p, q, r, s, t, u; g[0] = c, c.delegateTarget = this; if (!i.preDispatch || i.preDispatch.call(this, c) !== !1) { if (e && (!c.button || c.type !== "click")) { n = f(this), n.context = this.ownerDocument || this; for (m = c.target; m != this; m = m.parentNode || this) if (m.disabled !== !0) { p = {}, r = [], n[0] = m; for (k = 0; k < e; k++) s = d[k], t = s.selector, p[t] === b && (p[t] = s.quick ? H(m, s.quick) : n.is(t)), p[t] && r.push(s); r.length && j.push({ elem: m, matches: r }) } } d.length > e && j.push({ elem: this, matches: d.slice(e) }); for (k = 0; k < j.length && !c.isPropagationStopped() ; k++) { q = j[k], c.currentTarget = q.elem; for (l = 0; l < q.matches.length && !c.isImmediatePropagationStopped() ; l++) { s = q.matches[l]; if (h || !c.namespace && !s.namespace || c.namespace_re && c.namespace_re.test(s.namespace)) c.data = s.data, c.handleObj = s, o = ((f.event.special[s.origType] || {}).handle || s.handler).apply(q.elem, g), o !== b && (c.result = o, o === !1 && (c.preventDefault(), c.stopPropagation())) } } i.postDispatch && i.postDispatch.call(this, c); return c.result } }, props: "attrChange attrName relatedNode srcElement altKey bubbles cancelable ctrlKey currentTarget eventPhase metaKey relatedTarget shiftKey target timeStamp view which".split(" "), fixHooks: {}, keyHooks: { props: "char charCode key keyCode".split(" "), filter: function (a, b) { a.which == null && (a.which = b.charCode != null ? b.charCode : b.keyCode); return a } }, mouseHooks: { props: "button buttons clientX clientY fromElement offsetX offsetY pageX pageY screenX screenY toElement".split(" "), filter: function (a, d) { var e, f, g, h = d.button, i = d.fromElement; a.pageX == null && d.clientX != null && (e = a.target.ownerDocument || c, f = e.documentElement, g = e.body, a.pageX = d.clientX + (f && f.scrollLeft || g && g.scrollLeft || 0) - (f && f.clientLeft || g && g.clientLeft || 0), a.pageY = d.clientY + (f && f.scrollTop || g && g.scrollTop || 0) - (f && f.clientTop || g && g.clientTop || 0)), !a.relatedTarget && i && (a.relatedTarget = i === a.target ? d.toElement : i), !a.which && h !== b && (a.which = h & 1 ? 1 : h & 2 ? 3 : h & 4 ? 2 : 0); return a } }, fix: function (a) { if (a[f.expando]) return a; var d, e, g = a, h = f.event.fixHooks[a.type] || {}, i = h.props ? this.props.concat(h.props) : this.props; a = f.Event(g); for (d = i.length; d;) e = i[--d], a[e] = g[e]; a.target || (a.target = g.srcElement || c), a.target.nodeType === 3 && (a.target = a.target.parentNode), a.metaKey === b && (a.metaKey = a.ctrlKey); return h.filter ? h.filter(a, g) : a }, special: { ready: { setup: f.bindReady }, load: { noBubble: !0 }, focus: { delegateType: "focusin" }, blur: { delegateType: "focusout" }, beforeunload: { setup: function (a, b, c) { f.isWindow(this) && (this.onbeforeunload = c) }, teardown: function (a, b) { this.onbeforeunload === b && (this.onbeforeunload = null) } } }, simulate: function (a, b, c, d) { var e = f.extend(new f.Event, c, { type: a, isSimulated: !0, originalEvent: {} }); d ? f.event.trigger(e, null, b) : f.event.dispatch.call(b, e), e.isDefaultPrevented() && c.preventDefault() } }, f.event.handle = f.event.dispatch, f.removeEvent = c.removeEventListener ? function (a, b, c) { a.removeEventListener && a.removeEventListener(b, c, !1) } : function (a, b, c) { a.detachEvent && a.detachEvent("on" + b, c) }, f.Event = function (a, b) { if (!(this instanceof f.Event)) return new f.Event(a, b); a && a.type ? (this.originalEvent = a, this.type = a.type, this.isDefaultPrevented = a.defaultPrevented || a.returnValue === !1 || a.getPreventDefault && a.getPreventDefault() ? K : J) : this.type = a, b && f.extend(this, b), this.timeStamp = a && a.timeStamp || f.now(), this[f.expando] = !0 }, f.Event.prototype = { preventDefault: function () { this.isDefaultPrevented = K; var a = this.originalEvent; !a || (a.preventDefault ? a.preventDefault() : a.returnValue = !1) }, stopPropagation: function () { this.isPropagationStopped = K; var a = this.originalEvent; !a || (a.stopPropagation && a.stopPropagation(), a.cancelBubble = !0) }, stopImmediatePropagation: function () { this.isImmediatePropagationStopped = K, this.stopPropagation() }, isDefaultPrevented: J, isPropagationStopped: J, isImmediatePropagationStopped: J }, f.each({ mouseenter: "mouseover", mouseleave: "mouseout" }, function (a, b) { f.event.special[a] = { delegateType: b, bindType: b, handle: function (a) { var c = this, d = a.relatedTarget, e = a.handleObj, g = e.selector, h; if (!d || d !== c && !f.contains(c, d)) a.type = e.origType, h = e.handler.apply(this, arguments), a.type = b; return h } } }), f.support.submitBubbles || (f.event.special.submit = { setup: function () { if (f.nodeName(this, "form")) return !1; f.event.add(this, "click._submit keypress._submit", function (a) { var c = a.target, d = f.nodeName(c, "input") || f.nodeName(c, "button") ? c.form : b; d && !d._submit_attached && (f.event.add(d, "submit._submit", function (a) { a._submit_bubble = !0 }), d._submit_attached = !0) }) }, postDispatch: function (a) { a._submit_bubble && (delete a._submit_bubble, this.parentNode && !a.isTrigger && f.event.simulate("submit", this.parentNode, a, !0)) }, teardown: function () { if (f.nodeName(this, "form")) return !1; f.event.remove(this, "._submit") } }), f.support.changeBubbles || (f.event.special.change = { setup: function () { if (z.test(this.nodeName)) { if (this.type === "checkbox" || this.type === "radio") f.event.add(this, "propertychange._change", function (a) { a.originalEvent.propertyName === "checked" && (this._just_changed = !0) }), f.event.add(this, "click._change", function (a) { this._just_changed && !a.isTrigger && (this._just_changed = !1, f.event.simulate("change", this, a, !0)) }); return !1 } f.event.add(this, "beforeactivate._change", function (a) { var b = a.target; z.test(b.nodeName) && !b._change_attached && (f.event.add(b, "change._change", function (a) { this.parentNode && !a.isSimulated && !a.isTrigger && f.event.simulate("change", this.parentNode, a, !0) }), b._change_attached = !0) }) }, handle: function (a) { var b = a.target; if (this !== b || a.isSimulated || a.isTrigger || b.type !== "radio" && b.type !== "checkbox") return a.handleObj.handler.apply(this, arguments) }, teardown: function () { f.event.remove(this, "._change"); return z.test(this.nodeName) } }), f.support.focusinBubbles || f.each({ focus: "focusin", blur: "focusout" }, function (a, b) { var d = 0, e = function (a) { f.event.simulate(b, a.target, f.event.fix(a), !0) }; f.event.special[b] = { setup: function () { d++ === 0 && c.addEventListener(a, e, !0) }, teardown: function () { --d === 0 && c.removeEventListener(a, e, !0) } } }), f.fn.extend({ on: function (a, c, d, e, g) { var h, i; if (typeof a == "object") { typeof c != "string" && (d = d || c, c = b); for (i in a) this.on(i, c, d, a[i], g); return this } d == null && e == null ? (e = c, d = c = b) : e == null && (typeof c == "string" ? (e = d, d = b) : (e = d, d = c, c = b)); if (e === !1) e = J; else if (!e) return this; g === 1 && (h = e, e = function (a) { f().off(a); return h.apply(this, arguments) }, e.guid = h.guid || (h.guid = f.guid++)); return this.each(function () { f.event.add(this, a, e, d, c) }) }, one: function (a, b, c, d) { return this.on(a, b, c, d, 1) }, off: function (a, c, d) { if (a && a.preventDefault && a.handleObj) { var e = a.handleObj; f(a.delegateTarget).off(e.namespace ? e.origType + "." + e.namespace : e.origType, e.selector, e.handler); return this } if (typeof a == "object") { for (var g in a) this.off(g, c, a[g]); return this } if (c === !1 || typeof c == "function") d = c, c = b; d === !1 && (d = J); return this.each(function () { f.event.remove(this, a, d, c) }) }, bind: function (a, b, c) { return this.on(a, null, b, c) }, unbind: function (a, b) { return this.off(a, null, b) }, live: function (a, b, c) { f(this.context).on(a, this.selector, b, c); return this }, die: function (a, b) { f(this.context).off(a, this.selector || "**", b); return this }, delegate: function (a, b, c, d) { return this.on(b, a, c, d) }, undelegate: function (a, b, c) { return arguments.length == 1 ? this.off(a, "**") : this.off(b, a, c) }, trigger: function (a, b) { return this.each(function () { f.event.trigger(a, b, this) }) }, triggerHandler: function (a, b) { if (this[0]) return f.event.trigger(a, b, this[0], !0) }, toggle: function (a) { var b = arguments, c = a.guid || f.guid++, d = 0, e = function (c) { var e = (f._data(this, "lastToggle" + a.guid) || 0) % d; f._data(this, "lastToggle" + a.guid, e + 1), c.preventDefault(); return b[e].apply(this, arguments) || !1 }; e.guid = c; while (d < b.length) b[d++].guid = c; return this.click(e) }, hover: function (a, b) { return this.mouseenter(a).mouseleave(b || a) } }), f.each("blur focus focusin focusout load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup error contextmenu".split(" "), function (a, b) { f.fn[b] = function (a, c) { c == null && (c = a, a = null); return arguments.length > 0 ? this.on(b, null, a, c) : this.trigger(b) }, f.attrFn && (f.attrFn[b] = !0), C.test(b) && (f.event.fixHooks[b] = f.event.keyHooks), D.test(b) && (f.event.fixHooks[b] = f.event.mouseHooks) }), function () { function x(a, b, c, e, f, g) { for (var h = 0, i = e.length; h < i; h++) { var j = e[h]; if (j) { var k = !1; j = j[a]; while (j) { if (j[d] === c) { k = e[j.sizset]; break } if (j.nodeType === 1) { g || (j[d] = c, j.sizset = h); if (typeof b != "string") { if (j === b) { k = !0; break } } else if (m.filter(b, [j]).length > 0) { k = j; break } } j = j[a] } e[h] = k } } } function w(a, b, c, e, f, g) { for (var h = 0, i = e.length; h < i; h++) { var j = e[h]; if (j) { var k = !1; j = j[a]; while (j) { if (j[d] === c) { k = e[j.sizset]; break } j.nodeType === 1 && !g && (j[d] = c, j.sizset = h); if (j.nodeName.toLowerCase() === b) { k = j; break } j = j[a] } e[h] = k } } } var a = /((?:\((?:\([^()]+\)|[^()]+)+\)|\[(?:\[[^\[\]]*\]|['"][^'"]*['"]|[^\[\]'"]+)+\]|\\.|[^ >+~,(\[\\]+)+|[>+~])(\s*,\s*)?((?:.|\r|\n)*)/g, d = "sizcache" + (Math.random() + "").replace(".", ""), e = 0, g = Object.prototype.toString, h = !1, i = !0, j = /\\/g, k = /\r\n/g, l = /\W/;[0, 0].sort(function () { i = !1; return 0 }); var m = function (b, d, e, f) { e = e || [], d = d || c; var h = d; if (d.nodeType !== 1 && d.nodeType !== 9) return []; if (!b || typeof b != "string") return e; var i, j, k, l, n, q, r, t, u = !0, v = m.isXML(d), w = [], x = b; do { a.exec(""), i = a.exec(x); if (i) { x = i[3], w.push(i[1]); if (i[2]) { l = i[3]; break } } } while (i); if (w.length > 1 && p.exec(b)) if (w.length === 2 && o.relative[w[0]]) j = y(w[0] + w[1], d, f); else { j = o.relative[w[0]] ? [d] : m(w.shift(), d); while (w.length) b = w.shift(), o.relative[b] && (b += w.shift()), j = y(b, j, f) } else { !f && w.length > 1 && d.nodeType === 9 && !v && o.match.ID.test(w[0]) && !o.match.ID.test(w[w.length - 1]) && (n = m.find(w.shift(), d, v), d = n.expr ? m.filter(n.expr, n.set)[0] : n.set[0]); if (d) { n = f ? { expr: w.pop(), set: s(f) } : m.find(w.pop(), w.length === 1 && (w[0] === "~" || w[0] === "+") && d.parentNode ? d.parentNode : d, v), j = n.expr ? m.filter(n.expr, n.set) : n.set, w.length > 0 ? k = s(j) : u = !1; while (w.length) q = w.pop(), r = q, o.relative[q] ? r = w.pop() : q = "", r == null && (r = d), o.relative[q](k, r, v) } else k = w = [] } k || (k = j), k || m.error(q || b); if (g.call(k) === "[object Array]") if (!u) e.push.apply(e, k); else if (d && d.nodeType === 1) for (t = 0; k[t] != null; t++) k[t] && (k[t] === !0 || k[t].nodeType === 1 && m.contains(d, k[t])) && e.push(j[t]); else for (t = 0; k[t] != null; t++) k[t] && k[t].nodeType === 1 && e.push(j[t]); else s(k, e); l && (m(l, h, e, f), m.uniqueSort(e)); return e }; m.uniqueSort = function (a) { if (u) { h = i, a.sort(u); if (h) for (var b = 1; b < a.length; b++) a[b] === a[b - 1] && a.splice(b--, 1) } return a }, m.matches = function (a, b) { return m(a, null, null, b) }, m.matchesSelector = function (a, b) { return m(b, null, null, [a]).length > 0 }, m.find = function (a, b, c) { var d, e, f, g, h, i; if (!a) return []; for (e = 0, f = o.order.length; e < f; e++) { h = o.order[e]; if (g = o.leftMatch[h].exec(a)) { i = g[1], g.splice(1, 1); if (i.substr(i.length - 1) !== "\\") { g[1] = (g[1] || "").replace(j, ""), d = o.find[h](g, b, c); if (d != null) { a = a.replace(o.match[h], ""); break } } } } d || (d = typeof b.getElementsByTagName != "undefined" ? b.getElementsByTagName("*") : []); return { set: d, expr: a } }, m.filter = function (a, c, d, e) { var f, g, h, i, j, k, l, n, p, q = a, r = [], s = c, t = c && c[0] && m.isXML(c[0]); while (a && c.length) { for (h in o.filter) if ((f = o.leftMatch[h].exec(a)) != null && f[2]) { k = o.filter[h], l = f[1], g = !1, f.splice(1, 1); if (l.substr(l.length - 1) === "\\") continue; s === r && (r = []); if (o.preFilter[h]) { f = o.preFilter[h](f, s, d, r, e, t); if (!f) g = i = !0; else if (f === !0) continue } if (f) for (n = 0; (j = s[n]) != null; n++) j && (i = k(j, f, n, s), p = e ^ i, d && i != null ? p ? g = !0 : s[n] = !1 : p && (r.push(j), g = !0)); if (i !== b) { d || (s = r), a = a.replace(o.match[h], ""); if (!g) return []; break } } if (a === q) if (g == null) m.error(a); else break; q = a } return s }, m.error = function (a) { throw new Error("Syntax error, unrecognized expression: " + a) }; var n = m.getText = function (a) { var b, c, d = a.nodeType, e = ""; if (d) { if (d === 1 || d === 9 || d === 11) { if (typeof a.textContent == "string") return a.textContent; if (typeof a.innerText == "string") return a.innerText.replace(k, ""); for (a = a.firstChild; a; a = a.nextSibling) e += n(a) } else if (d === 3 || d === 4) return a.nodeValue } else for (b = 0; c = a[b]; b++) c.nodeType !== 8 && (e += n(c)); return e }, o = m.selectors = { order: ["ID", "NAME", "TAG"], match: { ID: /#((?:[\w\u00c0-\uFFFF\-]|\\.)+)/, CLASS: /\.((?:[\w\u00c0-\uFFFF\-]|\\.)+)/, NAME: /\[name=['"]*((?:[\w\u00c0-\uFFFF\-]|\\.)+)['"]*\]/, ATTR: /\[\s*((?:[\w\u00c0-\uFFFF\-]|\\.)+)\s*(?:(\S?=)\s*(?:(['"])(.*?)\3|(#?(?:[\w\u00c0-\uFFFF\-]|\\.)*)|)|)\s*\]/, TAG: /^((?:[\w\u00c0-\uFFFF\*\-]|\\.)+)/, CHILD: /:(only|nth|last|first)-child(?:\(\s*(even|odd|(?:[+\-]?\d+|(?:[+\-]?\d*)?n\s*(?:[+\-]\s*\d+)?))\s*\))?/, POS: /:(nth|eq|gt|lt|first|last|even|odd)(?:\((\d*)\))?(?=[^\-]|$)/, PSEUDO: /:((?:[\w\u00c0-\uFFFF\-]|\\.)+)(?:\((['"]?)((?:\([^\)]+\)|[^\(\)]*)+)\2\))?/ }, leftMatch: {}, attrMap: { "class": "className", "for": "htmlFor" }, attrHandle: { href: function (a) { return a.getAttribute("href") }, type: function (a) { return a.getAttribute("type") } }, relative: { "+": function (a, b) { var c = typeof b == "string", d = c && !l.test(b), e = c && !d; d && (b = b.toLowerCase()); for (var f = 0, g = a.length, h; f < g; f++) if (h = a[f]) { while ((h = h.previousSibling) && h.nodeType !== 1); a[f] = e || h && h.nodeName.toLowerCase() === b ? h || !1 : h === b } e && m.filter(b, a, !0) }, ">": function (a, b) { var c, d = typeof b == "string", e = 0, f = a.length; if (d && !l.test(b)) { b = b.toLowerCase(); for (; e < f; e++) { c = a[e]; if (c) { var g = c.parentNode; a[e] = g.nodeName.toLowerCase() === b ? g : !1 } } } else { for (; e < f; e++) c = a[e], c && (a[e] = d ? c.parentNode : c.parentNode === b); d && m.filter(b, a, !0) } }, "": function (a, b, c) { var d, f = e++, g = x; typeof b == "string" && !l.test(b) && (b = b.toLowerCase(), d = b, g = w), g("parentNode", b, f, a, d, c) }, "~": function (a, b, c) { var d, f = e++, g = x; typeof b == "string" && !l.test(b) && (b = b.toLowerCase(), d = b, g = w), g("previousSibling", b, f, a, d, c) } }, find: { ID: function (a, b, c) { if (typeof b.getElementById != "undefined" && !c) { var d = b.getElementById(a[1]); return d && d.parentNode ? [d] : [] } }, NAME: function (a, b) { if (typeof b.getElementsByName != "undefined") { var c = [], d = b.getElementsByName(a[1]); for (var e = 0, f = d.length; e < f; e++) d[e].getAttribute("name") === a[1] && c.push(d[e]); return c.length === 0 ? null : c } }, TAG: function (a, b) { if (typeof b.getElementsByTagName != "undefined") return b.getElementsByTagName(a[1]) } }, preFilter: { CLASS: function (a, b, c, d, e, f) { a = " " + a[1].replace(j, "") + " "; if (f) return a; for (var g = 0, h; (h = b[g]) != null; g++) h && (e ^ (h.className && (" " + h.className + " ").replace(/[\t\n\r]/g, " ").indexOf(a) >= 0) ? c || d.push(h) : c && (b[g] = !1)); return !1 }, ID: function (a) { return a[1].replace(j, "") }, TAG: function (a, b) { return a[1].replace(j, "").toLowerCase() }, CHILD: function (a) { if (a[1] === "nth") { a[2] || m.error(a[0]), a[2] = a[2].replace(/^\+|\s*/g, ""); var b = /(-?)(\d*)(?:n([+\-]?\d*))?/.exec(a[2] === "even" && "2n" || a[2] === "odd" && "2n+1" || !/\D/.test(a[2]) && "0n+" + a[2] || a[2]); a[2] = b[1] + (b[2] || 1) - 0, a[3] = b[3] - 0 } else a[2] && m.error(a[0]); a[0] = e++; return a }, ATTR: function (a, b, c, d, e, f) { var g = a[1] = a[1].replace(j, ""); !f && o.attrMap[g] && (a[1] = o.attrMap[g]), a[4] = (a[4] || a[5] || "").replace(j, ""), a[2] === "~=" && (a[4] = " " + a[4] + " "); return a }, PSEUDO: function (b, c, d, e, f) { if (b[1] === "not") if ((a.exec(b[3]) || "").length > 1 || /^\w/.test(b[3])) b[3] = m(b[3], null, null, c); else { var g = m.filter(b[3], c, d, !0 ^ f); d || e.push.apply(e, g); return !1 } else if (o.match.POS.test(b[0]) || o.match.CHILD.test(b[0])) return !0; return b }, POS: function (a) { a.unshift(!0); return a } }, filters: { enabled: function (a) { return a.disabled === !1 && a.type !== "hidden" }, disabled: function (a) { return a.disabled === !0 }, checked: function (a) { return a.checked === !0 }, selected: function (a) { a.parentNode && a.parentNode.selectedIndex; return a.selected === !0 }, parent: function (a) { return !!a.firstChild }, empty: function (a) { return !a.firstChild }, has: function (a, b, c) { return !!m(c[3], a).length }, header: function (a) { return /h\d/i.test(a.nodeName) }, text: function (a) { var b = a.getAttribute("type"), c = a.type; return a.nodeName.toLowerCase() === "input" && "text" === c && (b === c || b === null) }, radio: function (a) { return a.nodeName.toLowerCase() === "input" && "radio" === a.type }, checkbox: function (a) { return a.nodeName.toLowerCase() === "input" && "checkbox" === a.type }, file: function (a) { return a.nodeName.toLowerCase() === "input" && "file" === a.type }, password: function (a) { return a.nodeName.toLowerCase() === "input" && "password" === a.type }, submit: function (a) { var b = a.nodeName.toLowerCase(); return (b === "input" || b === "button") && "submit" === a.type }, image: function (a) { return a.nodeName.toLowerCase() === "input" && "image" === a.type }, reset: function (a) { var b = a.nodeName.toLowerCase(); return (b === "input" || b === "button") && "reset" === a.type }, button: function (a) { var b = a.nodeName.toLowerCase(); return b === "input" && "button" === a.type || b === "button" }, input: function (a) { return /input|select|textarea|button/i.test(a.nodeName) }, focus: function (a) { return a === a.ownerDocument.activeElement } }, setFilters: { first: function (a, b) { return b === 0 }, last: function (a, b, c, d) { return b === d.length - 1 }, even: function (a, b) { return b % 2 === 0 }, odd: function (a, b) { return b % 2 === 1 }, lt: function (a, b, c) { return b < c[3] - 0 }, gt: function (a, b, c) { return b > c[3] - 0 }, nth: function (a, b, c) { return c[3] - 0 === b }, eq: function (a, b, c) { return c[3] - 0 === b } }, filter: { PSEUDO: function (a, b, c, d) { var e = b[1], f = o.filters[e]; if (f) return f(a, c, b, d); if (e === "contains") return (a.textContent || a.innerText || n([a]) || "").indexOf(b[3]) >= 0; if (e === "not") { var g = b[3]; for (var h = 0, i = g.length; h < i; h++) if (g[h] === a) return !1; return !0 } m.error(e) }, CHILD: function (a, b) { var c, e, f, g, h, i, j, k = b[1], l = a; switch (k) { case "only": case "first": while (l = l.previousSibling) if (l.nodeType === 1) return !1; if (k === "first") return !0; l = a; case "last": while (l = l.nextSibling) if (l.nodeType === 1) return !1; return !0; case "nth": c = b[2], e = b[3]; if (c === 1 && e === 0) return !0; f = b[0], g = a.parentNode; if (g && (g[d] !== f || !a.nodeIndex)) { i = 0; for (l = g.firstChild; l; l = l.nextSibling) l.nodeType === 1 && (l.nodeIndex = ++i); g[d] = f } j = a.nodeIndex - e; return c === 0 ? j === 0 : j % c === 0 && j / c >= 0 } }, ID: function (a, b) { return a.nodeType === 1 && a.getAttribute("id") === b }, TAG: function (a, b) { return b === "*" && a.nodeType === 1 || !!a.nodeName && a.nodeName.toLowerCase() === b }, CLASS: function (a, b) { return (" " + (a.className || a.getAttribute("class")) + " ").indexOf(b) > -1 }, ATTR: function (a, b) { var c = b[1], d = m.attr ? m.attr(a, c) : o.attrHandle[c] ? o.attrHandle[c](a) : a[c] != null ? a[c] : a.getAttribute(c), e = d + "", f = b[2], g = b[4]; return d == null ? f === "!=" : !f && m.attr ? d != null : f === "=" ? e === g : f === "*=" ? e.indexOf(g) >= 0 : f === "~=" ? (" " + e + " ").indexOf(g) >= 0 : g ? f === "!=" ? e !== g : f === "^=" ? e.indexOf(g) === 0 : f === "$=" ? e.substr(e.length - g.length) === g : f === "|=" ? e === g || e.substr(0, g.length + 1) === g + "-" : !1 : e && d !== !1 }, POS: function (a, b, c, d) { var e = b[2], f = o.setFilters[e]; if (f) return f(a, c, b, d) } } }, p = o.match.POS, q = function (a, b) { return "\\" + (b - 0 + 1) }; for (var r in o.match) o.match[r] = new RegExp(o.match[r].source + /(?![^\[]*\])(?![^\(]*\))/.source), o.leftMatch[r] = new RegExp(/(^(?:.|\r|\n)*?)/.source + o.match[r].source.replace(/\\(\d+)/g, q)); o.match.globalPOS = p; var s = function (a, b) { a = Array.prototype.slice.call(a, 0); if (b) { b.push.apply(b, a); return b } return a }; try { Array.prototype.slice.call(c.documentElement.childNodes, 0)[0].nodeType } catch (t) { s = function (a, b) { var c = 0, d = b || []; if (g.call(a) === "[object Array]") Array.prototype.push.apply(d, a); else if (typeof a.length == "number") for (var e = a.length; c < e; c++) d.push(a[c]); else for (; a[c]; c++) d.push(a[c]); return d } } var u, v; c.documentElement.compareDocumentPosition ? u = function (a, b) { if (a === b) { h = !0; return 0 } if (!a.compareDocumentPosition || !b.compareDocumentPosition) return a.compareDocumentPosition ? -1 : 1; return a.compareDocumentPosition(b) & 4 ? -1 : 1 } : (u = function (a, b) { if (a === b) { h = !0; return 0 } if (a.sourceIndex && b.sourceIndex) return a.sourceIndex - b.sourceIndex; var c, d, e = [], f = [], g = a.parentNode, i = b.parentNode, j = g; if (g === i) return v(a, b); if (!g) return -1; if (!i) return 1; while (j) e.unshift(j), j = j.parentNode; j = i; while (j) f.unshift(j), j = j.parentNode; c = e.length, d = f.length; for (var k = 0; k < c && k < d; k++) if (e[k] !== f[k]) return v(e[k], f[k]); return k === c ? v(a, f[k], -1) : v(e[k], b, 1) }, v = function (a, b, c) { if (a === b) return c; var d = a.nextSibling; while (d) { if (d === b) return -1; d = d.nextSibling } return 1 }), function () { var a = c.createElement("div"), d = "script" + (new Date).getTime(), e = c.documentElement; a.innerHTML = "<a name='" + d + "'/>", e.insertBefore(a, e.firstChild), c.getElementById(d) && (o.find.ID = function (a, c, d) { if (typeof c.getElementById != "undefined" && !d) { var e = c.getElementById(a[1]); return e ? e.id === a[1] || typeof e.getAttributeNode != "undefined" && e.getAttributeNode("id").nodeValue === a[1] ? [e] : b : [] } }, o.filter.ID = function (a, b) { var c = typeof a.getAttributeNode != "undefined" && a.getAttributeNode("id"); return a.nodeType === 1 && c && c.nodeValue === b }), e.removeChild(a), e = a = null }(), function () { var a = c.createElement("div"); a.appendChild(c.createComment("")), a.getElementsByTagName("*").length > 0 && (o.find.TAG = function (a, b) { var c = b.getElementsByTagName(a[1]); if (a[1] === "*") { var d = []; for (var e = 0; c[e]; e++) c[e].nodeType === 1 && d.push(c[e]); c = d } return c }), a.innerHTML = "<a href='#'></a>", a.firstChild && typeof a.firstChild.getAttribute != "undefined" && a.firstChild.getAttribute("href") !== "#" && (o.attrHandle.href = function (a) { return a.getAttribute("href", 2) }), a = null }(), c.querySelectorAll && function () { var a = m, b = c.createElement("div"), d = "__sizzle__"; b.innerHTML = "<p class='TEST'></p>"; if (!b.querySelectorAll || b.querySelectorAll(".TEST").length !== 0) { m = function (b, e, f, g) { e = e || c; if (!g && !m.isXML(e)) { var h = /^(\w+$)|^\.([\w\-]+$)|^#([\w\-]+$)/.exec(b); if (h && (e.nodeType === 1 || e.nodeType === 9)) { if (h[1]) return s(e.getElementsByTagName(b), f); if (h[2] && o.find.CLASS && e.getElementsByClassName) return s(e.getElementsByClassName(h[2]), f) } if (e.nodeType === 9) { if (b === "body" && e.body) return s([e.body], f); if (h && h[3]) { var i = e.getElementById(h[3]); if (!i || !i.parentNode) return s([], f); if (i.id === h[3]) return s([i], f) } try { return s(e.querySelectorAll(b), f) } catch (j) { } } else if (e.nodeType === 1 && e.nodeName.toLowerCase() !== "object") { var k = e, l = e.getAttribute("id"), n = l || d, p = e.parentNode, q = /^\s*[+~]/.test(b); l ? n = n.replace(/'/g, "\\$&") : e.setAttribute("id", n), q && p && (e = e.parentNode); try { if (!q || p) return s(e.querySelectorAll("[id='" + n + "'] " + b), f) } catch (r) { } finally { l || k.removeAttribute("id") } } } return a(b, e, f, g) }; for (var e in a) m[e] = a[e]; b = null } }(), function () { var a = c.documentElement, b = a.matchesSelector || a.mozMatchesSelector || a.webkitMatchesSelector || a.msMatchesSelector; if (b) { var d = !b.call(c.createElement("div"), "div"), e = !1; try { b.call(c.documentElement, "[test!='']:sizzle") } catch (f) { e = !0 } m.matchesSelector = function (a, c) { c = c.replace(/\=\s*([^'"\]]*)\s*\]/g, "='$1']"); if (!m.isXML(a)) try { if (e || !o.match.PSEUDO.test(c) && !/!=/.test(c)) { var f = b.call(a, c); if (f || !d || a.document && a.document.nodeType !== 11) return f } } catch (g) { } return m(c, null, null, [a]).length > 0 } } }(), function () { var a = c.createElement("div"); a.innerHTML = "<div class='test e'></div><div class='test'></div>"; if (!!a.getElementsByClassName && a.getElementsByClassName("e").length !== 0) { a.lastChild.className = "e"; if (a.getElementsByClassName("e").length === 1) return; o.order.splice(1, 0, "CLASS"), o.find.CLASS = function (a, b, c) { if (typeof b.getElementsByClassName != "undefined" && !c) return b.getElementsByClassName(a[1]) }, a = null } }(), c.documentElement.contains ? m.contains = function (a, b) { return a !== b && (a.contains ? a.contains(b) : !0) } : c.documentElement.compareDocumentPosition ? m.contains = function (a, b) { return !!(a.compareDocumentPosition(b) & 16) } : m.contains = function () { return !1 }, m.isXML = function (a) { var b = (a ? a.ownerDocument || a : 0).documentElement; return b ? b.nodeName !== "HTML" : !1 }; var y = function (a, b, c) { var d, e = [], f = "", g = b.nodeType ? [b] : b; while (d = o.match.PSEUDO.exec(a)) f += d[0], a = a.replace(o.match.PSEUDO, ""); a = o.relative[a] ? a + "*" : a; for (var h = 0, i = g.length; h < i; h++) m(a, g[h], e, c); return m.filter(f, e) }; m.attr = f.attr, m.selectors.attrMap = {}, f.find = m, f.expr = m.selectors, f.expr[":"] = f.expr.filters, f.unique = m.uniqueSort, f.text = m.getText, f.isXMLDoc = m.isXML, f.contains = m.contains }(); var L = /Until$/, M = /^(?:parents|prevUntil|prevAll)/, N = /,/, O = /^.[^:#\[\.,]*$/, P = Array.prototype.slice, Q = f.expr.match.globalPOS, R = { children: !0, contents: !0, next: !0, prev: !0 }; f.fn.extend({ find: function (a) { var b = this, c, d; if (typeof a != "string") return f(a).filter(function () { for (c = 0, d = b.length; c < d; c++) if (f.contains(b[c], this)) return !0 }); var e = this.pushStack("", "find", a), g, h, i; for (c = 0, d = this.length; c < d; c++) { g = e.length, f.find(a, this[c], e); if (c > 0) for (h = g; h < e.length; h++) for (i = 0; i < g; i++) if (e[i] === e[h]) { e.splice(h--, 1); break } } return e }, has: function (a) { var b = f(a); return this.filter(function () { for (var a = 0, c = b.length; a < c; a++) if (f.contains(this, b[a])) return !0 }) }, not: function (a) { return this.pushStack(T(this, a, !1), "not", a) }, filter: function (a) { return this.pushStack(T(this, a, !0), "filter", a) }, is: function (a) { return !!a && (typeof a == "string" ? Q.test(a) ? f(a, this.context).index(this[0]) >= 0 : f.filter(a, this).length > 0 : this.filter(a).length > 0) }, closest: function (a, b) { var c = [], d, e, g = this[0]; if (f.isArray(a)) { var h = 1; while (g && g.ownerDocument && g !== b) { for (d = 0; d < a.length; d++) f(g).is(a[d]) && c.push({ selector: a[d], elem: g, level: h }); g = g.parentNode, h++ } return c } var i = Q.test(a) || typeof a != "string" ? f(a, b || this.context) : 0; for (d = 0, e = this.length; d < e; d++) { g = this[d]; while (g) { if (i ? i.index(g) > -1 : f.find.matchesSelector(g, a)) { c.push(g); break } g = g.parentNode; if (!g || !g.ownerDocument || g === b || g.nodeType === 11) break } } c = c.length > 1 ? f.unique(c) : c; return this.pushStack(c, "closest", a) }, index: function (a) { if (!a) return this[0] && this[0].parentNode ? this.prevAll().length : -1; if (typeof a == "string") return f.inArray(this[0], f(a)); return f.inArray(a.jquery ? a[0] : a, this) }, add: function (a, b) { var c = typeof a == "string" ? f(a, b) : f.makeArray(a && a.nodeType ? [a] : a), d = f.merge(this.get(), c); return this.pushStack(S(c[0]) || S(d[0]) ? d : f.unique(d)) }, andSelf: function () { return this.add(this.prevObject) } }), f.each({ parent: function (a) { var b = a.parentNode; return b && b.nodeType !== 11 ? b : null }, parents: function (a) { return f.dir(a, "parentNode") }, parentsUntil: function (a, b, c) { return f.dir(a, "parentNode", c) }, next: function (a) { return f.nth(a, 2, "nextSibling") }, prev: function (a) { return f.nth(a, 2, "previousSibling") }, nextAll: function (a) { return f.dir(a, "nextSibling") }, prevAll: function (a) { return f.dir(a, "previousSibling") }, nextUntil: function (a, b, c) { return f.dir(a, "nextSibling", c) }, prevUntil: function (a, b, c) { return f.dir(a, "previousSibling", c) }, siblings: function (a) { return f.sibling((a.parentNode || {}).firstChild, a) }, children: function (a) { return f.sibling(a.firstChild) }, contents: function (a) { return f.nodeName(a, "iframe") ? a.contentDocument || a.contentWindow.document : f.makeArray(a.childNodes) } }, function (a, b) { f.fn[a] = function (c, d) { var e = f.map(this, b, c); L.test(a) || (d = c), d && typeof d == "string" && (e = f.filter(d, e)), e = this.length > 1 && !R[a] ? f.unique(e) : e, (this.length > 1 || N.test(d)) && M.test(a) && (e = e.reverse()); return this.pushStack(e, a, P.call(arguments).join(",")) } }), f.extend({ filter: function (a, b, c) { c && (a = ":not(" + a + ")"); return b.length === 1 ? f.find.matchesSelector(b[0], a) ? [b[0]] : [] : f.find.matches(a, b) }, dir: function (a, c, d) { var e = [], g = a[c]; while (g && g.nodeType !== 9 && (d === b || g.nodeType !== 1 || !f(g).is(d))) g.nodeType === 1 && e.push(g), g = g[c]; return e }, nth: function (a, b, c, d) { b = b || 1; var e = 0; for (; a; a = a[c]) if (a.nodeType === 1 && ++e === b) break; return a }, sibling: function (a, b) { var c = []; for (; a; a = a.nextSibling) a.nodeType === 1 && a !== b && c.push(a); return c } }); var V = "abbr|article|aside|audio|bdi|canvas|data|datalist|details|figcaption|figure|footer|header|hgroup|mark|meter|nav|output|progress|section|summary|time|video", W = / jQuery\d+="(?:\d+|null)"/g, X = /^\s+/, Y = /<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/ig, Z = /<([\w:]+)/, $ = /<tbody/i, _ = /<|&#?\w+;/, ba = /<(?:script|style)/i, bb = /<(?:script|object|embed|option|style)/i, bc = new RegExp("<(?:" + V + ")[\\s/>]", "i"), bd = /checked\s*(?:[^=]|=\s*.checked.)/i, be = /\/(java|ecma)script/i, bf = /^\s*<!(?:\[CDATA\[|\-\-)/, bg = { option: [1, "<select multiple='multiple'>", "</select>"], legend: [1, "<fieldset>", "</fieldset>"], thead: [1, "<table>", "</table>"], tr: [2, "<table><tbody>", "</tbody></table>"], td: [3, "<table><tbody><tr>", "</tr></tbody></table>"], col: [2, "<table><tbody></tbody><colgroup>", "</colgroup></table>"], area: [1, "<map>", "</map>"], _default: [0, "", ""] }, bh = U(c); bg.optgroup = bg.option, bg.tbody = bg.tfoot = bg.colgroup = bg.caption = bg.thead, bg.th = bg.td, f.support.htmlSerialize || (bg._default = [1, "div<div>", "</div>"]), f.fn.extend({
        text: function (a) { return f.access(this, function (a) { return a === b ? f.text(this) : this.empty().append((this[0] && this[0].ownerDocument || c).createTextNode(a)) }, null, a, arguments.length) }, wrapAll: function (a) { if (f.isFunction(a)) return this.each(function (b) { f(this).wrapAll(a.call(this, b)) }); if (this[0]) { var b = f(a, this[0].ownerDocument).eq(0).clone(!0); this[0].parentNode && b.insertBefore(this[0]), b.map(function () { var a = this; while (a.firstChild && a.firstChild.nodeType === 1) a = a.firstChild; return a }).append(this) } return this }, wrapInner: function (a) { if (f.isFunction(a)) return this.each(function (b) { f(this).wrapInner(a.call(this, b)) }); return this.each(function () { var b = f(this), c = b.contents(); c.length ? c.wrapAll(a) : b.append(a) }) }, wrap: function (a) { var b = f.isFunction(a); return this.each(function (c) { f(this).wrapAll(b ? a.call(this, c) : a) }) }, unwrap: function () { return this.parent().each(function () { f.nodeName(this, "body") || f(this).replaceWith(this.childNodes) }).end() }, append: function () { return this.domManip(arguments, !0, function (a) { this.nodeType === 1 && this.appendChild(a) }) }, prepend: function () { return this.domManip(arguments, !0, function (a) { this.nodeType === 1 && this.insertBefore(a, this.firstChild) }) }, before: function () {
            if (this[0] && this[0].parentNode) return this.domManip(arguments, !1, function (a) { this.parentNode.insertBefore(a, this) }); if (arguments.length) {
                var a = f
                .clean(arguments); a.push.apply(a, this.toArray()); return this.pushStack(a, "before", arguments)
            }
        }, after: function () { if (this[0] && this[0].parentNode) return this.domManip(arguments, !1, function (a) { this.parentNode.insertBefore(a, this.nextSibling) }); if (arguments.length) { var a = this.pushStack(this, "after", arguments); a.push.apply(a, f.clean(arguments)); return a } }, remove: function (a, b) { for (var c = 0, d; (d = this[c]) != null; c++) if (!a || f.filter(a, [d]).length) !b && d.nodeType === 1 && (f.cleanData(d.getElementsByTagName("*")), f.cleanData([d])), d.parentNode && d.parentNode.removeChild(d); return this }, empty: function () { for (var a = 0, b; (b = this[a]) != null; a++) { b.nodeType === 1 && f.cleanData(b.getElementsByTagName("*")); while (b.firstChild) b.removeChild(b.firstChild) } return this }, clone: function (a, b) { a = a == null ? !1 : a, b = b == null ? a : b; return this.map(function () { return f.clone(this, a, b) }) }, html: function (a) { return f.access(this, function (a) { var c = this[0] || {}, d = 0, e = this.length; if (a === b) return c.nodeType === 1 ? c.innerHTML.replace(W, "") : null; if (typeof a == "string" && !ba.test(a) && (f.support.leadingWhitespace || !X.test(a)) && !bg[(Z.exec(a) || ["", ""])[1].toLowerCase()]) { a = a.replace(Y, "<$1></$2>"); try { for (; d < e; d++) c = this[d] || {}, c.nodeType === 1 && (f.cleanData(c.getElementsByTagName("*")), c.innerHTML = a); c = 0 } catch (g) { } } c && this.empty().append(a) }, null, a, arguments.length) }, replaceWith: function (a) { if (this[0] && this[0].parentNode) { if (f.isFunction(a)) return this.each(function (b) { var c = f(this), d = c.html(); c.replaceWith(a.call(this, b, d)) }); typeof a != "string" && (a = f(a).detach()); return this.each(function () { var b = this.nextSibling, c = this.parentNode; f(this).remove(), b ? f(b).before(a) : f(c).append(a) }) } return this.length ? this.pushStack(f(f.isFunction(a) ? a() : a), "replaceWith", a) : this }, detach: function (a) { return this.remove(a, !0) }, domManip: function (a, c, d) { var e, g, h, i, j = a[0], k = []; if (!f.support.checkClone && arguments.length === 3 && typeof j == "string" && bd.test(j)) return this.each(function () { f(this).domManip(a, c, d, !0) }); if (f.isFunction(j)) return this.each(function (e) { var g = f(this); a[0] = j.call(this, e, c ? g.html() : b), g.domManip(a, c, d) }); if (this[0]) { i = j && j.parentNode, f.support.parentNode && i && i.nodeType === 11 && i.childNodes.length === this.length ? e = { fragment: i } : e = f.buildFragment(a, this, k), h = e.fragment, h.childNodes.length === 1 ? g = h = h.firstChild : g = h.firstChild; if (g) { c = c && f.nodeName(g, "tr"); for (var l = 0, m = this.length, n = m - 1; l < m; l++) d.call(c ? bi(this[l], g) : this[l], e.cacheable || m > 1 && l < n ? f.clone(h, !0, !0) : h) } k.length && f.each(k, function (a, b) { b.src ? f.ajax({ type: "GET", global: !1, url: b.src, async: !1, dataType: "script" }) : f.globalEval((b.text || b.textContent || b.innerHTML || "").replace(bf, "/*$0*/")), b.parentNode && b.parentNode.removeChild(b) }) } return this }
    }), f.buildFragment = function (a, b, d) { var e, g, h, i, j = a[0]; b && b[0] && (i = b[0].ownerDocument || b[0]), i.createDocumentFragment || (i = c), a.length === 1 && typeof j == "string" && j.length < 512 && i === c && j.charAt(0) === "<" && !bb.test(j) && (f.support.checkClone || !bd.test(j)) && (f.support.html5Clone || !bc.test(j)) && (g = !0, h = f.fragments[j], h && h !== 1 && (e = h)), e || (e = i.createDocumentFragment(), f.clean(a, i, e, d)), g && (f.fragments[j] = h ? e : 1); return { fragment: e, cacheable: g } }, f.fragments = {}, f.each({ appendTo: "append", prependTo: "prepend", insertBefore: "before", insertAfter: "after", replaceAll: "replaceWith" }, function (a, b) { f.fn[a] = function (c) { var d = [], e = f(c), g = this.length === 1 && this[0].parentNode; if (g && g.nodeType === 11 && g.childNodes.length === 1 && e.length === 1) { e[b](this[0]); return this } for (var h = 0, i = e.length; h < i; h++) { var j = (h > 0 ? this.clone(!0) : this).get(); f(e[h])[b](j), d = d.concat(j) } return this.pushStack(d, a, e.selector) } }), f.extend({ clone: function (a, b, c) { var d, e, g, h = f.support.html5Clone || f.isXMLDoc(a) || !bc.test("<" + a.nodeName + ">") ? a.cloneNode(!0) : bo(a); if ((!f.support.noCloneEvent || !f.support.noCloneChecked) && (a.nodeType === 1 || a.nodeType === 11) && !f.isXMLDoc(a)) { bk(a, h), d = bl(a), e = bl(h); for (g = 0; d[g]; ++g) e[g] && bk(d[g], e[g]) } if (b) { bj(a, h); if (c) { d = bl(a), e = bl(h); for (g = 0; d[g]; ++g) bj(d[g], e[g]) } } d = e = null; return h }, clean: function (a, b, d, e) { var g, h, i, j = []; b = b || c, typeof b.createElement == "undefined" && (b = b.ownerDocument || b[0] && b[0].ownerDocument || c); for (var k = 0, l; (l = a[k]) != null; k++) { typeof l == "number" && (l += ""); if (!l) continue; if (typeof l == "string") if (!_.test(l)) l = b.createTextNode(l); else { l = l.replace(Y, "<$1></$2>"); var m = (Z.exec(l) || ["", ""])[1].toLowerCase(), n = bg[m] || bg._default, o = n[0], p = b.createElement("div"), q = bh.childNodes, r; b === c ? bh.appendChild(p) : U(b).appendChild(p), p.innerHTML = n[1] + l + n[2]; while (o--) p = p.lastChild; if (!f.support.tbody) { var s = $.test(l), t = m === "table" && !s ? p.firstChild && p.firstChild.childNodes : n[1] === "<table>" && !s ? p.childNodes : []; for (i = t.length - 1; i >= 0; --i) f.nodeName(t[i], "tbody") && !t[i].childNodes.length && t[i].parentNode.removeChild(t[i]) } !f.support.leadingWhitespace && X.test(l) && p.insertBefore(b.createTextNode(X.exec(l)[0]), p.firstChild), l = p.childNodes, p && (p.parentNode.removeChild(p), q.length > 0 && (r = q[q.length - 1], r && r.parentNode && r.parentNode.removeChild(r))) } var u; if (!f.support.appendChecked) if (l[0] && typeof (u = l.length) == "number") for (i = 0; i < u; i++) bn(l[i]); else bn(l); l.nodeType ? j.push(l) : j = f.merge(j, l) } if (d) { g = function (a) { return !a.type || be.test(a.type) }; for (k = 0; j[k]; k++) { h = j[k]; if (e && f.nodeName(h, "script") && (!h.type || be.test(h.type))) e.push(h.parentNode ? h.parentNode.removeChild(h) : h); else { if (h.nodeType === 1) { var v = f.grep(h.getElementsByTagName("script"), g); j.splice.apply(j, [k + 1, 0].concat(v)) } d.appendChild(h) } } } return j }, cleanData: function (a) { var b, c, d = f.cache, e = f.event.special, g = f.support.deleteExpando; for (var h = 0, i; (i = a[h]) != null; h++) { if (i.nodeName && f.noData[i.nodeName.toLowerCase()]) continue; c = i[f.expando]; if (c) { b = d[c]; if (b && b.events) { for (var j in b.events) e[j] ? f.event.remove(i, j) : f.removeEvent(i, j, b.handle); b.handle && (b.handle.elem = null) } g ? delete i[f.expando] : i.removeAttribute && i.removeAttribute(f.expando), delete d[c] } } } }); var bp = /alpha\([^)]*\)/i, bq = /opacity=([^)]*)/, br = /([A-Z]|^ms)/g, bs = /^[\-+]?(?:\d*\.)?\d+$/i, bt = /^-?(?:\d*\.)?\d+(?!px)[^\d\s]+$/i, bu = /^([\-+])=([\-+.\de]+)/, bv = /^margin/, bw = { position: "absolute", visibility: "hidden", display: "block" }, bx = ["Top", "Right", "Bottom", "Left"], by, bz, bA; f.fn.css = function (a, c) { return f.access(this, function (a, c, d) { return d !== b ? f.style(a, c, d) : f.css(a, c) }, a, c, arguments.length > 1) }, f.extend({ cssHooks: { opacity: { get: function (a, b) { if (b) { var c = by(a, "opacity"); return c === "" ? "1" : c } return a.style.opacity } } }, cssNumber: { fillOpacity: !0, fontWeight: !0, lineHeight: !0, opacity: !0, orphans: !0, widows: !0, zIndex: !0, zoom: !0 }, cssProps: { "float": f.support.cssFloat ? "cssFloat" : "styleFloat" }, style: function (a, c, d, e) { if (!!a && a.nodeType !== 3 && a.nodeType !== 8 && !!a.style) { var g, h, i = f.camelCase(c), j = a.style, k = f.cssHooks[i]; c = f.cssProps[i] || i; if (d === b) { if (k && "get" in k && (g = k.get(a, !1, e)) !== b) return g; return j[c] } h = typeof d, h === "string" && (g = bu.exec(d)) && (d = +(g[1] + 1) * +g[2] + parseFloat(f.css(a, c)), h = "number"); if (d == null || h === "number" && isNaN(d)) return; h === "number" && !f.cssNumber[i] && (d += "px"); if (!k || !("set" in k) || (d = k.set(a, d)) !== b) try { j[c] = d } catch (l) { } } }, css: function (a, c, d) { var e, g; c = f.camelCase(c), g = f.cssHooks[c], c = f.cssProps[c] || c, c === "cssFloat" && (c = "float"); if (g && "get" in g && (e = g.get(a, !0, d)) !== b) return e; if (by) return by(a, c) }, swap: function (a, b, c) { var d = {}, e, f; for (f in b) d[f] = a.style[f], a.style[f] = b[f]; e = c.call(a); for (f in b) a.style[f] = d[f]; return e } }), f.curCSS = f.css, c.defaultView && c.defaultView.getComputedStyle && (bz = function (a, b) { var c, d, e, g, h = a.style; b = b.replace(br, "-$1").toLowerCase(), (d = a.ownerDocument.defaultView) && (e = d.getComputedStyle(a, null)) && (c = e.getPropertyValue(b), c === "" && !f.contains(a.ownerDocument.documentElement, a) && (c = f.style(a, b))), !f.support.pixelMargin && e && bv.test(b) && bt.test(c) && (g = h.width, h.width = c, c = e.width, h.width = g); return c }), c.documentElement.currentStyle && (bA = function (a, b) { var c, d, e, f = a.currentStyle && a.currentStyle[b], g = a.style; f == null && g && (e = g[b]) && (f = e), bt.test(f) && (c = g.left, d = a.runtimeStyle && a.runtimeStyle.left, d && (a.runtimeStyle.left = a.currentStyle.left), g.left = b === "fontSize" ? "1em" : f, f = g.pixelLeft + "px", g.left = c, d && (a.runtimeStyle.left = d)); return f === "" ? "auto" : f }), by = bz || bA, f.each(["height", "width"], function (a, b) { f.cssHooks[b] = { get: function (a, c, d) { if (c) return a.offsetWidth !== 0 ? bB(a, b, d) : f.swap(a, bw, function () { return bB(a, b, d) }) }, set: function (a, b) { return bs.test(b) ? b + "px" : b } } }), f.support.opacity || (f.cssHooks.opacity = { get: function (a, b) { return bq.test((b && a.currentStyle ? a.currentStyle.filter : a.style.filter) || "") ? parseFloat(RegExp.$1) / 100 + "" : b ? "1" : "" }, set: function (a, b) { var c = a.style, d = a.currentStyle, e = f.isNumeric(b) ? "alpha(opacity=" + b * 100 + ")" : "", g = d && d.filter || c.filter || ""; c.zoom = 1; if (b >= 1 && f.trim(g.replace(bp, "")) === "") { c.removeAttribute("filter"); if (d && !d.filter) return } c.filter = bp.test(g) ? g.replace(bp, e) : g + " " + e } }), f(function () { f.support.reliableMarginRight || (f.cssHooks.marginRight = { get: function (a, b) { return f.swap(a, { display: "inline-block" }, function () { return b ? by(a, "margin-right") : a.style.marginRight }) } }) }), f.expr && f.expr.filters && (f.expr.filters.hidden = function (a) { var b = a.offsetWidth, c = a.offsetHeight; return b === 0 && c === 0 || !f.support.reliableHiddenOffsets && (a.style && a.style.display || f.css(a, "display")) === "none" }, f.expr.filters.visible = function (a) { return !f.expr.filters.hidden(a) }), f.each({ margin: "", padding: "", border: "Width" }, function (a, b) { f.cssHooks[a + b] = { expand: function (c) { var d, e = typeof c == "string" ? c.split(" ") : [c], f = {}; for (d = 0; d < 4; d++) f[a + bx[d] + b] = e[d] || e[d - 2] || e[0]; return f } } }); var bC = /%20/g, bD = /\[\]$/, bE = /\r?\n/g, bF = /#.*$/, bG = /^(.*?):[ \t]*([^\r\n]*)\r?$/mg, bH = /^(?:color|date|datetime|datetime-local|email|hidden|month|number|password|range|search|tel|text|time|url|week)$/i, bI = /^(?:about|app|app\-storage|.+\-extension|file|res|widget):$/, bJ = /^(?:GET|HEAD)$/, bK = /^\/\//, bL = /\?/, bM = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, bN = /^(?:select|textarea)/i, bO = /\s+/, bP = /([?&])_=[^&]*/, bQ = /^([\w\+\.\-]+:)(?:\/\/([^\/?#:]*)(?::(\d+))?)?/, bR = f.fn.load, bS = {}, bT = {}, bU, bV, bW = ["*/"] + ["*"]; try { bU = e.href } catch (bX) { bU = c.createElement("a"), bU.href = "", bU = bU.href } bV = bQ.exec(bU.toLowerCase()) || [], f.fn.extend({ load: function (a, c, d) { if (typeof a != "string" && bR) return bR.apply(this, arguments); if (!this.length) return this; var e = a.indexOf(" "); if (e >= 0) { var g = a.slice(e, a.length); a = a.slice(0, e) } var h = "GET"; c && (f.isFunction(c) ? (d = c, c = b) : typeof c == "object" && (c = f.param(c, f.ajaxSettings.traditional), h = "POST")); var i = this; f.ajax({ url: a, type: h, dataType: "html", data: c, complete: function (a, b, c) { c = a.responseText, a.isResolved() && (a.done(function (a) { c = a }), i.html(g ? f("<div>").append(c.replace(bM, "")).find(g) : c)), d && i.each(d, [c, b, a]) } }); return this }, serialize: function () { return f.param(this.serializeArray()) }, serializeArray: function () { return this.map(function () { return this.elements ? f.makeArray(this.elements) : this }).filter(function () { return this.name && !this.disabled && (this.checked || bN.test(this.nodeName) || bH.test(this.type)) }).map(function (a, b) { var c = f(this).val(); return c == null ? null : f.isArray(c) ? f.map(c, function (a, c) { return { name: b.name, value: a.replace(bE, "\r\n") } }) : { name: b.name, value: c.replace(bE, "\r\n") } }).get() } }), f.each("ajaxStart ajaxStop ajaxComplete ajaxError ajaxSuccess ajaxSend".split(" "), function (a, b) { f.fn[b] = function (a) { return this.on(b, a) } }), f.each(["get", "post"], function (a, c) { f[c] = function (a, d, e, g) { f.isFunction(d) && (g = g || e, e = d, d = b); return f.ajax({ type: c, url: a, data: d, success: e, dataType: g }) } }), f.extend({ getScript: function (a, c) { return f.get(a, b, c, "script") }, getJSON: function (a, b, c) { return f.get(a, b, c, "json") }, ajaxSetup: function (a, b) { b ? b$(a, f.ajaxSettings) : (b = a, a = f.ajaxSettings), b$(a, b); return a }, ajaxSettings: { url: bU, isLocal: bI.test(bV[1]), global: !0, type: "GET", contentType: "application/x-www-form-urlencoded; charset=UTF-8", processData: !0, async: !0, accepts: { xml: "application/xml, text/xml", html: "text/html", text: "text/plain", json: "application/json, text/javascript", "*": bW }, contents: { xml: /xml/, html: /html/, json: /json/ }, responseFields: { xml: "responseXML", text: "responseText" }, converters: { "* text": a.String, "text html": !0, "text json": f.parseJSON, "text xml": f.parseXML }, flatOptions: { context: !0, url: !0 } }, ajaxPrefilter: bY(bS), ajaxTransport: bY(bT), ajax: function (a, c) { function w(a, c, l, m) { if (s !== 2) { s = 2, q && clearTimeout(q), p = b, n = m || "", v.readyState = a > 0 ? 4 : 0; var o, r, u, w = c, x = l ? ca(d, v, l) : b, y, z; if (a >= 200 && a < 300 || a === 304) { if (d.ifModified) { if (y = v.getResponseHeader("Last-Modified")) f.lastModified[k] = y; if (z = v.getResponseHeader("Etag")) f.etag[k] = z } if (a === 304) w = "notmodified", o = !0; else try { r = cb(d, x), w = "success", o = !0 } catch (A) { w = "parsererror", u = A } } else { u = w; if (!w || a) w = "error", a < 0 && (a = 0) } v.status = a, v.statusText = "" + (c || w), o ? h.resolveWith(e, [r, w, v]) : h.rejectWith(e, [v, w, u]), v.statusCode(j), j = b, t && g.trigger("ajax" + (o ? "Success" : "Error"), [v, d, o ? r : u]), i.fireWith(e, [v, w]), t && (g.trigger("ajaxComplete", [v, d]), --f.active || f.event.trigger("ajaxStop")) } } typeof a == "object" && (c = a, a = b), c = c || {}; var d = f.ajaxSetup({}, c), e = d.context || d, g = e !== d && (e.nodeType || e instanceof f) ? f(e) : f.event, h = f.Deferred(), i = f.Callbacks("once memory"), j = d.statusCode || {}, k, l = {}, m = {}, n, o, p, q, r, s = 0, t, u, v = { readyState: 0, setRequestHeader: function (a, b) { if (!s) { var c = a.toLowerCase(); a = m[c] = m[c] || a, l[a] = b } return this }, getAllResponseHeaders: function () { return s === 2 ? n : null }, getResponseHeader: function (a) { var c; if (s === 2) { if (!o) { o = {}; while (c = bG.exec(n)) o[c[1].toLowerCase()] = c[2] } c = o[a.toLowerCase()] } return c === b ? null : c }, overrideMimeType: function (a) { s || (d.mimeType = a); return this }, abort: function (a) { a = a || "abort", p && p.abort(a), w(0, a); return this } }; h.promise(v), v.success = v.done, v.error = v.fail, v.complete = i.add, v.statusCode = function (a) { if (a) { var b; if (s < 2) for (b in a) j[b] = [j[b], a[b]]; else b = a[v.status], v.then(b, b) } return this }, d.url = ((a || d.url) + "").replace(bF, "").replace(bK, bV[1] + "//"), d.dataTypes = f.trim(d.dataType || "*").toLowerCase().split(bO), d.crossDomain == null && (r = bQ.exec(d.url.toLowerCase()), d.crossDomain = !(!r || r[1] == bV[1] && r[2] == bV[2] && (r[3] || (r[1] === "http:" ? 80 : 443)) == (bV[3] || (bV[1] === "http:" ? 80 : 443)))), d.data && d.processData && typeof d.data != "string" && (d.data = f.param(d.data, d.traditional)), bZ(bS, d, c, v); if (s === 2) return !1; t = d.global, d.type = d.type.toUpperCase(), d.hasContent = !bJ.test(d.type), t && f.active++ === 0 && f.event.trigger("ajaxStart"); if (!d.hasContent) { d.data && (d.url += (bL.test(d.url) ? "&" : "?") + d.data, delete d.data), k = d.url; if (d.cache === !1) { var x = f.now(), y = d.url.replace(bP, "$1_=" + x); d.url = y + (y === d.url ? (bL.test(d.url) ? "&" : "?") + "_=" + x : "") } } (d.data && d.hasContent && d.contentType !== !1 || c.contentType) && v.setRequestHeader("Content-Type", d.contentType), d.ifModified && (k = k || d.url, f.lastModified[k] && v.setRequestHeader("If-Modified-Since", f.lastModified[k]), f.etag[k] && v.setRequestHeader("If-None-Match", f.etag[k])), v.setRequestHeader("Accept", d.dataTypes[0] && d.accepts[d.dataTypes[0]] ? d.accepts[d.dataTypes[0]] + (d.dataTypes[0] !== "*" ? ", " + bW + "; q=0.01" : "") : d.accepts["*"]); for (u in d.headers) v.setRequestHeader(u, d.headers[u]); if (d.beforeSend && (d.beforeSend.call(e, v, d) === !1 || s === 2)) { v.abort(); return !1 } for (u in { success: 1, error: 1, complete: 1 }) v[u](d[u]); p = bZ(bT, d, c, v); if (!p) w(-1, "No Transport"); else { v.readyState = 1, t && g.trigger("ajaxSend", [v, d]), d.async && d.timeout > 0 && (q = setTimeout(function () { v.abort("timeout") }, d.timeout)); try { s = 1, p.send(l, w) } catch (z) { if (s < 2) w(-1, z); else throw z } } return v }, param: function (a, c) { var d = [], e = function (a, b) { b = f.isFunction(b) ? b() : b, d[d.length] = encodeURIComponent(a) + "=" + encodeURIComponent(b) }; c === b && (c = f.ajaxSettings.traditional); if (f.isArray(a) || a.jquery && !f.isPlainObject(a)) f.each(a, function () { e(this.name, this.value) }); else for (var g in a) b_(g, a[g], c, e); return d.join("&").replace(bC, "+") } }), f.extend({ active: 0, lastModified: {}, etag: {} }); var cc = f.now(), cd = /(\=)\?(&|$)|\?\?/i; f.ajaxSetup({ jsonp: "callback", jsonpCallback: function () { return f.expando + "_" + cc++ } }), f.ajaxPrefilter("json jsonp", function (b, c, d) { var e = typeof b.data == "string" && /^application\/x\-www\-form\-urlencoded/.test(b.contentType); if (b.dataTypes[0] === "jsonp" || b.jsonp !== !1 && (cd.test(b.url) || e && cd.test(b.data))) { var g, h = b.jsonpCallback = f.isFunction(b.jsonpCallback) ? b.jsonpCallback() : b.jsonpCallback, i = a[h], j = b.url, k = b.data, l = "$1" + h + "$2"; b.jsonp !== !1 && (j = j.replace(cd, l), b.url === j && (e && (k = k.replace(cd, l)), b.data === k && (j += (/\?/.test(j) ? "&" : "?") + b.jsonp + "=" + h))), b.url = j, b.data = k, a[h] = function (a) { g = [a] }, d.always(function () { a[h] = i, g && f.isFunction(i) && a[h](g[0]) }), b.converters["script json"] = function () { g || f.error(h + " was not called"); return g[0] }, b.dataTypes[0] = "json"; return "script" } }), f.ajaxSetup({ accepts: { script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript" }, contents: { script: /javascript|ecmascript/ }, converters: { "text script": function (a) { f.globalEval(a); return a } } }), f.ajaxPrefilter("script", function (a) { a.cache === b && (a.cache = !1), a.crossDomain && (a.type = "GET", a.global = !1) }), f.ajaxTransport("script", function (a) { if (a.crossDomain) { var d, e = c.head || c.getElementsByTagName("head")[0] || c.documentElement; return { send: function (f, g) { d = c.createElement("script"), d.async = "async", a.scriptCharset && (d.charset = a.scriptCharset), d.src = a.url, d.onload = d.onreadystatechange = function (a, c) { if (c || !d.readyState || /loaded|complete/.test(d.readyState)) d.onload = d.onreadystatechange = null, e && d.parentNode && e.removeChild(d), d = b, c || g(200, "success") }, e.insertBefore(d, e.firstChild) }, abort: function () { d && d.onload(0, 1) } } } }); var ce = a.ActiveXObject ? function () { for (var a in cg) cg[a](0, 1) } : !1, cf = 0, cg; f.ajaxSettings.xhr = a.ActiveXObject ? function () { return !this.isLocal && ch() || ci() } : ch, function (a) { f.extend(f.support, { ajax: !!a, cors: !!a && "withCredentials" in a }) }(f.ajaxSettings.xhr()), f.support.ajax && f.ajaxTransport(function (c) { if (!c.crossDomain || f.support.cors) { var d; return { send: function (e, g) { var h = c.xhr(), i, j; c.username ? h.open(c.type, c.url, c.async, c.username, c.password) : h.open(c.type, c.url, c.async); if (c.xhrFields) for (j in c.xhrFields) h[j] = c.xhrFields[j]; c.mimeType && h.overrideMimeType && h.overrideMimeType(c.mimeType), !c.crossDomain && !e["X-Requested-With"] && (e["X-Requested-With"] = "XMLHttpRequest"); try { for (j in e) h.setRequestHeader(j, e[j]) } catch (k) { } h.send(c.hasContent && c.data || null), d = function (a, e) { var j, k, l, m, n; try { if (d && (e || h.readyState === 4)) { d = b, i && (h.onreadystatechange = f.noop, ce && delete cg[i]); if (e) h.readyState !== 4 && h.abort(); else { j = h.status, l = h.getAllResponseHeaders(), m = {}, n = h.responseXML, n && n.documentElement && (m.xml = n); try { m.text = h.responseText } catch (a) { } try { k = h.statusText } catch (o) { k = "" } !j && c.isLocal && !c.crossDomain ? j = m.text ? 200 : 404 : j === 1223 && (j = 204) } } } catch (p) { e || g(-1, p) } m && g(j, k, m, l) }, !c.async || h.readyState === 4 ? d() : (i = ++cf, ce && (cg || (cg = {}, f(a).unload(ce)), cg[i] = d), h.onreadystatechange = d) }, abort: function () { d && d(0, 1) } } } }); var cj = {}, ck, cl, cm = /^(?:toggle|show|hide)$/, cn = /^([+\-]=)?([\d+.\-]+)([a-z%]*)$/i, co, cp = [["height", "marginTop", "marginBottom", "paddingTop", "paddingBottom"], ["width", "marginLeft", "marginRight", "paddingLeft", "paddingRight"], ["opacity"]], cq; f.fn.extend({ show: function (a, b, c) { var d, e; if (a || a === 0) return this.animate(ct("show", 3), a, b, c); for (var g = 0, h = this.length; g < h; g++) d = this[g], d.style && (e = d.style.display, !f._data(d, "olddisplay") && e === "none" && (e = d.style.display = ""), (e === "" && f.css(d, "display") === "none" || !f.contains(d.ownerDocument.documentElement, d)) && f._data(d, "olddisplay", cu(d.nodeName))); for (g = 0; g < h; g++) { d = this[g]; if (d.style) { e = d.style.display; if (e === "" || e === "none") d.style.display = f._data(d, "olddisplay") || "" } } return this }, hide: function (a, b, c) { if (a || a === 0) return this.animate(ct("hide", 3), a, b, c); var d, e, g = 0, h = this.length; for (; g < h; g++) d = this[g], d.style && (e = f.css(d, "display"), e !== "none" && !f._data(d, "olddisplay") && f._data(d, "olddisplay", e)); for (g = 0; g < h; g++) this[g].style && (this[g].style.display = "none"); return this }, _toggle: f.fn.toggle, toggle: function (a, b, c) { var d = typeof a == "boolean"; f.isFunction(a) && f.isFunction(b) ? this._toggle.apply(this, arguments) : a == null || d ? this.each(function () { var b = d ? a : f(this).is(":hidden"); f(this)[b ? "show" : "hide"]() }) : this.animate(ct("toggle", 3), a, b, c); return this }, fadeTo: function (a, b, c, d) { return this.filter(":hidden").css("opacity", 0).show().end().animate({ opacity: b }, a, c, d) }, animate: function (a, b, c, d) { function g() { e.queue === !1 && f._mark(this); var b = f.extend({}, e), c = this.nodeType === 1, d = c && f(this).is(":hidden"), g, h, i, j, k, l, m, n, o, p, q; b.animatedProperties = {}; for (i in a) { g = f.camelCase(i), i !== g && (a[g] = a[i], delete a[i]); if ((k = f.cssHooks[g]) && "expand" in k) { l = k.expand(a[g]), delete a[g]; for (i in l) i in a || (a[i] = l[i]) } } for (g in a) { h = a[g], f.isArray(h) ? (b.animatedProperties[g] = h[1], h = a[g] = h[0]) : b.animatedProperties[g] = b.specialEasing && b.specialEasing[g] || b.easing || "swing"; if (h === "hide" && d || h === "show" && !d) return b.complete.call(this); c && (g === "height" || g === "width") && (b.overflow = [this.style.overflow, this.style.overflowX, this.style.overflowY], f.css(this, "display") === "inline" && f.css(this, "float") === "none" && (!f.support.inlineBlockNeedsLayout || cu(this.nodeName) === "inline" ? this.style.display = "inline-block" : this.style.zoom = 1)) } b.overflow != null && (this.style.overflow = "hidden"); for (i in a) j = new f.fx(this, b, i), h = a[i], cm.test(h) ? (q = f._data(this, "toggle" + i) || (h === "toggle" ? d ? "show" : "hide" : 0), q ? (f._data(this, "toggle" + i, q === "show" ? "hide" : "show"), j[q]()) : j[h]()) : (m = cn.exec(h), n = j.cur(), m ? (o = parseFloat(m[2]), p = m[3] || (f.cssNumber[i] ? "" : "px"), p !== "px" && (f.style(this, i, (o || 1) + p), n = (o || 1) / j.cur() * n, f.style(this, i, n + p)), m[1] && (o = (m[1] === "-=" ? -1 : 1) * o + n), j.custom(n, o, p)) : j.custom(n, h, "")); return !0 } var e = f.speed(b, c, d); if (f.isEmptyObject(a)) return this.each(e.complete, [!1]); a = f.extend({}, a); return e.queue === !1 ? this.each(g) : this.queue(e.queue, g) }, stop: function (a, c, d) { typeof a != "string" && (d = c, c = a, a = b), c && a !== !1 && this.queue(a || "fx", []); return this.each(function () { function h(a, b, c) { var e = b[c]; f.removeData(a, c, !0), e.stop(d) } var b, c = !1, e = f.timers, g = f._data(this); d || f._unmark(!0, this); if (a == null) for (b in g) g[b] && g[b].stop && b.indexOf(".run") === b.length - 4 && h(this, g, b); else g[b = a + ".run"] && g[b].stop && h(this, g, b); for (b = e.length; b--;) e[b].elem === this && (a == null || e[b].queue === a) && (d ? e[b](!0) : e[b].saveState(), c = !0, e.splice(b, 1)); (!d || !c) && f.dequeue(this, a) }) } }), f.each({ slideDown: ct("show", 1), slideUp: ct("hide", 1), slideToggle: ct("toggle", 1), fadeIn: { opacity: "show" }, fadeOut: { opacity: "hide" }, fadeToggle: { opacity: "toggle" } }, function (a, b) { f.fn[a] = function (a, c, d) { return this.animate(b, a, c, d) } }), f.extend({ speed: function (a, b, c) { var d = a && typeof a == "object" ? f.extend({}, a) : { complete: c || !c && b || f.isFunction(a) && a, duration: a, easing: c && b || b && !f.isFunction(b) && b }; d.duration = f.fx.off ? 0 : typeof d.duration == "number" ? d.duration : d.duration in f.fx.speeds ? f.fx.speeds[d.duration] : f.fx.speeds._default; if (d.queue == null || d.queue === !0) d.queue = "fx"; d.old = d.complete, d.complete = function (a) { f.isFunction(d.old) && d.old.call(this), d.queue ? f.dequeue(this, d.queue) : a !== !1 && f._unmark(this) }; return d }, easing: { linear: function (a) { return a }, swing: function (a) { return -Math.cos(a * Math.PI) / 2 + .5 } }, timers: [], fx: function (a, b, c) { this.options = b, this.elem = a, this.prop = c, b.orig = b.orig || {} } }), f.fx.prototype = { update: function () { this.options.step && this.options.step.call(this.elem, this.now, this), (f.fx.step[this.prop] || f.fx.step._default)(this) }, cur: function () { if (this.elem[this.prop] != null && (!this.elem.style || this.elem.style[this.prop] == null)) return this.elem[this.prop]; var a, b = f.css(this.elem, this.prop); return isNaN(a = parseFloat(b)) ? !b || b === "auto" ? 0 : b : a }, custom: function (a, c, d) { function h(a) { return e.step(a) } var e = this, g = f.fx; this.startTime = cq || cr(), this.end = c, this.now = this.start = a, this.pos = this.state = 0, this.unit = d || this.unit || (f.cssNumber[this.prop] ? "" : "px"), h.queue = this.options.queue, h.elem = this.elem, h.saveState = function () { f._data(e.elem, "fxshow" + e.prop) === b && (e.options.hide ? f._data(e.elem, "fxshow" + e.prop, e.start) : e.options.show && f._data(e.elem, "fxshow" + e.prop, e.end)) }, h() && f.timers.push(h) && !co && (co = setInterval(g.tick, g.interval)) }, show: function () { var a = f._data(this.elem, "fxshow" + this.prop); this.options.orig[this.prop] = a || f.style(this.elem, this.prop), this.options.show = !0, a !== b ? this.custom(this.cur(), a) : this.custom(this.prop === "width" || this.prop === "height" ? 1 : 0, this.cur()), f(this.elem).show() }, hide: function () { this.options.orig[this.prop] = f._data(this.elem, "fxshow" + this.prop) || f.style(this.elem, this.prop), this.options.hide = !0, this.custom(this.cur(), 0) }, step: function (a) { var b, c, d, e = cq || cr(), g = !0, h = this.elem, i = this.options; if (a || e >= i.duration + this.startTime) { this.now = this.end, this.pos = this.state = 1, this.update(), i.animatedProperties[this.prop] = !0; for (b in i.animatedProperties) i.animatedProperties[b] !== !0 && (g = !1); if (g) { i.overflow != null && !f.support.shrinkWrapBlocks && f.each(["", "X", "Y"], function (a, b) { h.style["overflow" + b] = i.overflow[a] }), i.hide && f(h).hide(); if (i.hide || i.show) for (b in i.animatedProperties) f.style(h, b, i.orig[b]), f.removeData(h, "fxshow" + b, !0), f.removeData(h, "toggle" + b, !0); d = i.complete, d && (i.complete = !1, d.call(h)) } return !1 } i.duration == Infinity ? this.now = e : (c = e - this.startTime, this.state = c / i.duration, this.pos = f.easing[i.animatedProperties[this.prop]](this.state, c, 0, 1, i.duration), this.now = this.start + (this.end - this.start) * this.pos), this.update(); return !0 } }, f.extend(f.fx, { tick: function () { var a, b = f.timers, c = 0; for (; c < b.length; c++) a = b[c], !a() && b[c] === a && b.splice(c--, 1); b.length || f.fx.stop() }, interval: 13, stop: function () { clearInterval(co), co = null }, speeds: { slow: 600, fast: 200, _default: 400 }, step: { opacity: function (a) { f.style(a.elem, "opacity", a.now) }, _default: function (a) { a.elem.style && a.elem.style[a.prop] != null ? a.elem.style[a.prop] = a.now + a.unit : a.elem[a.prop] = a.now } } }), f.each(cp.concat.apply([], cp), function (a, b) { b.indexOf("margin") && (f.fx.step[b] = function (a) { f.style(a.elem, b, Math.max(0, a.now) + a.unit) }) }), f.expr && f.expr.filters && (f.expr.filters.animated = function (a) { return f.grep(f.timers, function (b) { return a === b.elem }).length }); var cv, cw = /^t(?:able|d|h)$/i, cx = /^(?:body|html)$/i; "getBoundingClientRect" in c.documentElement ? cv = function (a, b, c, d) { try { d = a.getBoundingClientRect() } catch (e) { } if (!d || !f.contains(c, a)) return d ? { top: d.top, left: d.left } : { top: 0, left: 0 }; var g = b.body, h = cy(b), i = c.clientTop || g.clientTop || 0, j = c.clientLeft || g.clientLeft || 0, k = h.pageYOffset || f.support.boxModel && c.scrollTop || g.scrollTop, l = h.pageXOffset || f.support.boxModel && c.scrollLeft || g.scrollLeft, m = d.top + k - i, n = d.left + l - j; return { top: m, left: n } } : cv = function (a, b, c) { var d, e = a.offsetParent, g = a, h = b.body, i = b.defaultView, j = i ? i.getComputedStyle(a, null) : a.currentStyle, k = a.offsetTop, l = a.offsetLeft; while ((a = a.parentNode) && a !== h && a !== c) { if (f.support.fixedPosition && j.position === "fixed") break; d = i ? i.getComputedStyle(a, null) : a.currentStyle, k -= a.scrollTop, l -= a.scrollLeft, a === e && (k += a.offsetTop, l += a.offsetLeft, f.support.doesNotAddBorder && (!f.support.doesAddBorderForTableAndCells || !cw.test(a.nodeName)) && (k += parseFloat(d.borderTopWidth) || 0, l += parseFloat(d.borderLeftWidth) || 0), g = e, e = a.offsetParent), f.support.subtractsBorderForOverflowNotVisible && d.overflow !== "visible" && (k += parseFloat(d.borderTopWidth) || 0, l += parseFloat(d.borderLeftWidth) || 0), j = d } if (j.position === "relative" || j.position === "static") k += h.offsetTop, l += h.offsetLeft; f.support.fixedPosition && j.position === "fixed" && (k += Math.max(c.scrollTop, h.scrollTop), l += Math.max(c.scrollLeft, h.scrollLeft)); return { top: k, left: l } }, f.fn.offset = function (a) { if (arguments.length) return a === b ? this : this.each(function (b) { f.offset.setOffset(this, a, b) }); var c = this[0], d = c && c.ownerDocument; if (!d) return null; if (c === d.body) return f.offset.bodyOffset(c); return cv(c, d, d.documentElement) }, f.offset = { bodyOffset: function (a) { var b = a.offsetTop, c = a.offsetLeft; f.support.doesNotIncludeMarginInBodyOffset && (b += parseFloat(f.css(a, "marginTop")) || 0, c += parseFloat(f.css(a, "marginLeft")) || 0); return { top: b, left: c } }, setOffset: function (a, b, c) { var d = f.css(a, "position"); d === "static" && (a.style.position = "relative"); var e = f(a), g = e.offset(), h = f.css(a, "top"), i = f.css(a, "left"), j = (d === "absolute" || d === "fixed") && f.inArray("auto", [h, i]) > -1, k = {}, l = {}, m, n; j ? (l = e.position(), m = l.top, n = l.left) : (m = parseFloat(h) || 0, n = parseFloat(i) || 0), f.isFunction(b) && (b = b.call(a, c, g)), b.top != null && (k.top = b.top - g.top + m), b.left != null && (k.left = b.left - g.left + n), "using" in b ? b.using.call(a, k) : e.css(k) } }, f.fn.extend({ position: function () { if (!this[0]) return null; var a = this[0], b = this.offsetParent(), c = this.offset(), d = cx.test(b[0].nodeName) ? { top: 0, left: 0 } : b.offset(); c.top -= parseFloat(f.css(a, "marginTop")) || 0, c.left -= parseFloat(f.css(a, "marginLeft")) || 0, d.top += parseFloat(f.css(b[0], "borderTopWidth")) || 0, d.left += parseFloat(f.css(b[0], "borderLeftWidth")) || 0; return { top: c.top - d.top, left: c.left - d.left } }, offsetParent: function () { return this.map(function () { var a = this.offsetParent || c.body; while (a && !cx.test(a.nodeName) && f.css(a, "position") === "static") a = a.offsetParent; return a }) } }), f.each({ scrollLeft: "pageXOffset", scrollTop: "pageYOffset" }, function (a, c) { var d = /Y/.test(c); f.fn[a] = function (e) { return f.access(this, function (a, e, g) { var h = cy(a); if (g === b) return h ? c in h ? h[c] : f.support.boxModel && h.document.documentElement[e] || h.document.body[e] : a[e]; h ? h.scrollTo(d ? f(h).scrollLeft() : g, d ? g : f(h).scrollTop()) : a[e] = g }, a, e, arguments.length, null) } }), f.each({ Height: "height", Width: "width" }, function (a, c) { var d = "client" + a, e = "scroll" + a, g = "offset" + a; f.fn["inner" + a] = function () { var a = this[0]; return a ? a.style ? parseFloat(f.css(a, c, "padding")) : this[c]() : null }, f.fn["outer" + a] = function (a) { var b = this[0]; return b ? b.style ? parseFloat(f.css(b, c, a ? "margin" : "border")) : this[c]() : null }, f.fn[c] = function (a) { return f.access(this, function (a, c, h) { var i, j, k, l; if (f.isWindow(a)) { i = a.document, j = i.documentElement[d]; return f.support.boxModel && j || i.body && i.body[d] || j } if (a.nodeType === 9) { i = a.documentElement; if (i[d] >= i[e]) return i[d]; return Math.max(a.body[e], i[e], a.body[g], i[g]) } if (h === b) { k = f.css(a, c), l = parseFloat(k); return f.isNumeric(l) ? l : k } f(a).css(c, h) }, c, a, arguments.length, null) } }), a.jQuery = a.$ = f, typeof define == "function" && define.amd && define.amd.jQuery && define("jquery", [], function () { return f })
})(window);
        
		
           }
		    var activePage = 1;
          
            var totalPage = 0; 
		    var  pageCount = 0;
		    function ShowCurrentPage() {
			
                totalPage = $('.VATTEMP').length;
                // draw controls
                showPaginationBar(totalPage);
				pageCount =totalPage;
                // show first page
                showPageContent(1);
            };
			   function showPaginationBar (numPages) {
                var pagins = '';
                for (var i = 1; i <= numPages; i++) {
				  $($('.VATTEMP')[i-1]).hide();
                    pagins += '<span class="number" id="ap' + i + '" onclick="showPageContent(' + i + '); return false;">' + i + '</span>';
                }
				
                $('.pagination span:first-child').after(pagins);
					$('#prev').click(function () {
                if (activePage > 1)
                    showPageContent(activePage - 1);
            });
            // and Next
            $('#next').click(function () {
                if (activePage < pageCount)
                    showPageContent(activePage + 1);
            });
            };
			   function showPageContent (page) {
			   
			   $($('.VATTEMP')[activePage-1]).hide();
			   
			           $($('.VATTEMP')[page-1]).show();
                $(".number").removeClass("selected");
                $("#ap" + page).addClass("selected");
                activePage = page;
			   
           
            };
			
		
		
		
		
		
		
		
		
		</script>
		
		]]>
			</xsl:text>
		<script>
		
          function displayCert(certName){window.external.displayCert(certName);}function htmlEncode(value) {return $('<div/>').text(value).html();}function htmlDecode(value) {return $('<div/>').html(value).text();}
        
		
		
		</script>
			</head>
			<body>
				<center>
          <div id="printView" style="position: relative;background-color: white;WIDTH: 100%;">
			  
            <xsl:choose>
              <xsl:when test="/Invoice/Invcancel!=''">
                <img style="position: absolute;z-index: 3;" width="790px" height="760px" src="data:image/png;base64,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" />
              </xsl:when>
            </xsl:choose>
			<xsl:for-each select="Invoice//Content">
				<div class="VATTEMP">
					<div id="quantitypages" style="padding-left:36px">
						<xsl:call-template name="main">
							<xsl:with-param name="pagesNeededfnc" select="$pagesNeeded"/>
							<xsl:with-param name="itemCountfnc" select="count(Products//Product)"/>
							<xsl:with-param name="itemNeeded" select="$itemsPerPage"/>
						</xsl:call-template>
					</div>
				</div>
			</xsl:for-each>
						<!--<xsl:for-each select="Invoice//Content/Products/Product[(position()-1) mod 10 = 0]">
						<xsl:variable name="level1Count" select="(position()-1)*10"/>-->					
				
			</div>
			
		</center>
	</body>
</html>

</xsl:template>

</xsl:stylesheet>