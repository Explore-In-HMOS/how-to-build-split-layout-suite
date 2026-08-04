export interface Metric {
  key: string;
  label: string;
  value: number;
  unit: string;
}

export class HealthStore {
  // Vitals (ColumnSplit mode)
  static readonly heartRate: number = 72;
  static readonly steps: number = 6420;

  // Compare (RowSplit mode) — today vs yesterday
  static readonly stepsToday: number = 6420;
  static readonly stepsYesterday: number = 8950;
  static readonly caloriesToday: number = 410;
  static readonly caloriesYesterday: number = 530;

  // Tiles (Flex mode)
  static tiles(): Metric[] {
    return [
      { key: 'hr', label: 'HR', value: 72, unit: 'bpm' },
      { key: 'steps', label: 'Steps', value: 6420, unit: '' },
      { key: 'kcal', label: 'Cal', value: 410, unit: 'kcal' },
      { key: 'spo2', label: 'SpO₂', value: 98, unit: '%' },
      { key: 'dist', label: 'Dist', value: 4, unit: 'km' },
      { key: 'sleep', label: 'Sleep', value: 7, unit: 'h' }
    ];
  }
}