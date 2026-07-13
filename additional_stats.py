def calc_cost(row):
    # Alma billing: 5p per CPU billing-unit-hour, 240p per GPU-hour.
    # The billing TRES already accounts for the cores (and any partition billing
    # weights), so it multiplies WALL-CLOCK hours, not CPUtime. 'CPUtime (hours)' is
    # NCPUS * wall, so wall = CPUtime / NCPUS; dividing the cores back out is what
    # stops the cost being quadratic in the core count.
    if not isinstance(row['AllocTRES'], str):
        return 0
    alloc_tres = dict(kv.split('=', 1) for kv in row['AllocTRES'].split(',') if '=' in kv)
    n_cpus = int(alloc_tres.get('cpu', 0))
    n_bills = int(alloc_tres.get('billing', n_cpus))
    gpu_vals = [int(v) for k, v in alloc_tres.items() if k.startswith('gres/gpu')]
    n_gpus = max(gpu_vals) if gpu_vals else 0
    elapsed_hours = row['CPUtime (hours)'] / n_cpus if n_cpus else 0
    cost = (5 * n_bills * elapsed_hours) / 100
    cost += (240 * n_gpus * elapsed_hours) / 100
    return cost

def calc_used_CPU_hours(row):
    try:
        time_without_ms = row['TotalCPU'].split('.')[0]
        time_h_m_d = time_without_ms.split(':')
        d,h,m,s = 0,0,0,0
        if len(time_h_m_d) == 4:
            d,h,m,s = time_h_m_d[0],time_h_m_d[1],time_h_m_d[2],time_h_m_d[3]
        elif len(time_h_m_d) == 3:
            h,m,s = time_h_m_d[0],time_h_m_d[1],time_h_m_d[2]
        elif len(time_h_m_d) == 2:
            m,s = time_h_m_d[0],time_h_m_d[1]
        elif len(time_h_m_d) == 1:
            s = time_h_m_d[0]
        hours = (int(d)*86400 + int(h)*3600 + int(m)*60 + int(s)) / 3600
        return hours
    except:
        return 0
    
def calc_allocated_CPU_hours(row):
    time_h_m_d = row['CPUTime'].split(':')
    h,m,s = time_h_m_d[0],time_h_m_d[1],time_h_m_d[2]
    d = 0
    try: 
        int(h)
    except:
        d = h.split('-')[0]
        h = h.split('-')[1]
    hours = (int(d)*86400 + int(h)*3600 + int(m)*60 + int(s)) / 3600
    return hours

def calc_efficiency(row):
        if row['CPUtime (hours)'] != 0:
            return row['TotalCPU (hours)'] / row['CPUtime (hours)']
        return 0