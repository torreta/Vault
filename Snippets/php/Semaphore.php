<?php

/**
 * User: fdelgado
 * Date: 11/7/16
 * Time: 11:18 AM
 */
class Semaphore
{

    private static $saleKey = 1;
    private static $cNoticeKey = 2;
    private static $lotKey = 12345;
    private static $invoiceKey = 5;
    private static $claimKey = 88;
    private static $commissionKey = 6;
    private static $paymentKey = 369;
    private static $continue = false;
    private static $currentKey;
    private static $creditKey = 12333;
    private static $debitKey = 2001;
    private static $bucketKey = 3258;


    /**
     * Get semaphore key and acquire it
     * @param $key int Semaphore identifier
     * @throws Exception If semaphore could not be acquired
     */
    public static function acquire($key)
    {
        if (strtoupper(substr(PHP_OS, 0, 3)) === 'LIN') {
            self::$continue = true;
            $semID = sem_get($key, 1, 0666, 1);

            if ($semID == false) {
                throw new Exception("Could not acquire semaphore.");
            }

            static::$currentKey = $semID;
            sem_acquire($semID);
        }

    }

    /**
     * Release semaphore lock
     */
    public static function release()
    {
        if (self::$continue){
            sem_release(static::$currentKey);
            sem_remove(static::$currentKey);
        }
    }

    /**
     * @return int
     */
    public static function getSaleKey()
    {
        return self::$saleKey;
    }

    /**
     * @return int
     */
    public static function getCNoticeKey()
    {
        return self::$cNoticeKey;
    }

    /**
     * @return int
     */
    public static function getLotKey()
    {
        return self::$lotKey;
    }

    /**
     * @return int
     */
    public static function getInvoiceKey()
    {
        return self::$invoiceKey;
    }

    /**
     * @return int
     */
    public static function getInvoiceKeySpecified($key)
    {
       $sem = self::$invoiceKey;
       $key = $sem + $key;
       return $key;
    }

    /**
     * @return int
     */
    public static function getClaimKey()
    {
        return self::$claimKey;
    }

    /**
     * @return int
     */
    public static function getClaimKeySpecified($key)
    {
       $sem = self::$claimKey;
       $key = $sem + $key;
       return $key;
    }

    /**
     * @return int
     */
    public static function getCommissionKey()
    {
        return self::$commissionKey;
    }

    /**
     * @return int
     */
    public static function getPaymentKey()
    {
        return self::$paymentKey;
    }

    /**
     * @return int
     */
    public static function getCreditKey()
    {
       return self::$creditKey;
    }

    /**
     * @return int
     */
    public static function getCreditKeySpecified($key)
    {
        $sem = self::$creditKey;
        $key = $sem + $key;
        return $key;
    }

    /**
     * @return int
     */
    public static function getDebitKey()
    {
       return self::$debitKey;
    }

    /**
     * @return int
     */
    public static function getDebitKeySpecified($key)
    {
        $sem = self::$debitKey;
        $key = $sem + $key;
        return $key;
    }

    /**
     * @return int
     */
    public static function getBucketKey()
    {
       return self::$bucketKey;
    }

    /**
     * @return int
     */
    public static function getBucketKeySpecified($key)
    {
        $sem = self::$bucketKey;
        $key = $sem + $key;
        return $key;
    }

}
