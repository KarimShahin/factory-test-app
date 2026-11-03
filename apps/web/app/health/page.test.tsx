import { render, screen } from '@testing-library/react';
import { describe, expect, it } from 'vitest';
import HealthPage from './page';

describe('health page', () => {
  it('renders ok', () => {
    render(<HealthPage />);
    expect(screen.getByText('ok')).toBeTruthy();
  });
});
