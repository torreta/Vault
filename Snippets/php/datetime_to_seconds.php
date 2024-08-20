
    private function dateIntervalToSeconds(\DateInterval $interval) {
        // Calculate the total number of seconds
        $seconds = 0;
        
        // Add seconds
        $seconds += $interval->s;
        
        // Add minutes
        $seconds += $interval->i * 60;
        
        // Add hours
        $seconds += $interval->h * 3600;
        
        // Add days
        $seconds += $interval->d * 86400;
        
        // Add months (approximate, assuming 30 days per month)
        $seconds += $interval->m * 30 * 86400;
        
        // Add years (approximate, assuming 365 days per year)
        $seconds += $interval->y * 365 * 86400;
        
        return $seconds;
    }
    