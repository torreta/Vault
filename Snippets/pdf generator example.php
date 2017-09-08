<?php

require('../services/common.php');
require_once('../vendors/tcpdf/tcpdf.php');

  ob_start();

  if(isset($_GET['saleorder_num'])){ $saleorder_num = $_GET['saleorder_num']; }
  if(isset($_GET['invoice_num'])){ $invoice_num = $_GET['invoice_num']; }
  if(isset($_GET['last'])){ $last = $_GET['last']; }

  $items = json_decode($data,true);

  $items_tam = count($items);
  $pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);

  $pdf->SetCreator(PDF_CREATOR);
  if(isset($_GET['saleorder_num'])){$pdf->SetTitle("Factura(s). Pedido: $saleorder_num");}
  if(isset($_GET['invoice_num'])){$pdf->SetTitle("FA-$invoice_num");}
  if(isset($_GET['last'])){$pdf->SetTitle("Factura más reciente");}
  $pdf->SetSubject('10');
  $pdf->SetFont('times', '', 10, '', 'false');
  $pdf->setPrintHeader(false);
  $pdf->setPrintFooter(false);
  $pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);
  $pdf->SetMargins(10, PDF_MARGIN_TOP+10, 10);
  $pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
  $pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);

  if(isset($_GET['saleorder_num'])){$itemswithlocator = Q::getAll("SELECT view_invoice_pdf_general.*,config.name,config.obs FROM view_invoice_pdf_general,config WHERE view_invoice_pdf_general.saleorder_number = $saleorder_num");}
  if(isset($_GET['invoice_num'])){$itemswithlocator = Q::getAll("SELECT view_invoice_pdf_general.*,config.name,config.obs FROM view_invoice_pdf_general,config WHERE view_invoice_pdf_general.invoice_number = $invoice_num");}
  if(isset($_GET['last'])){$itemswithlocator = Q::getAll("SELECT view_invoice_pdf_general.*,config.name,config.obs FROM view_invoice_pdf_general,config ORDER BY view_invoice_pdf_general.`invoice_number` DESC LIMIT 1");}

  foreach($itemswithlocator as $itemwithloc){
  $pdf->AddPage();

    $itemwithloc =(object)$itemwithloc;
    $te = new TE();
    $te->setObject($itemwithloc);
    if(isset($_GET['saleorder_num'])){$te->rows = Q::getAll("SELECT * FROM view_invoice_items_pdf_general WHERE invoice_number =".($itemwithloc->invoice_number));}
    if(isset($_GET['invoice_num'])){$te->rows = Q::getAll("SELECT * FROM view_invoice_items_pdf_general WHERE invoice_number = $invoice_num");}
    if(isset($_GET['last'])){$te->rows = Q::getAll("SELECT * FROM view_invoice_items_pdf_general WHERE invoice_number = (SELECT view_invoice_pdf_general.invoice_number FROM view_invoice_pdf_general ORDER BY view_invoice_pdf_general.`invoice_number` DESC LIMIT 1)");}
    $tpl = file_get_contents("../apps/dispatch/view/invoice_list.html");
    $html= $te->parse($tpl);

    $pdf->writeHTML($html);
  }

  $pdf->lastPage();
  ob_end_clean();
  if(isset($_GET['saleorder_num'])){$pdf->Output('FA-'.$itemwithloc->invoice_number.'.pdf', 'I');}
  if(isset($_GET['invoice_num'])){$pdf->Output("FA-$invoice_num.pdf", 'I');}
  if(isset($_GET['last'])){$pdf->Output('Factura.pdf', 'I');}

?>
