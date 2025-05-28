//
//  String+Extension.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/27/25.
//

import Foundation

extension String {
    
    /// 정규 표현식을 사용하여 문자열이 유효한 이메일 주소인지 판단합니다.
    ///
    /// 유효한 이메일 주소가 되기 위해서는 다음 조건을 모두 충족해야 합니다:
    /// - 로컬 파트(＠ 이전)는 특수문자로 시작하거나 끝나면 안 됩니다.
    /// - 로컬 파트와 도메인 파트는 반드시 ＠(at 기호)로 구분되어야 합니다.
    /// - 도메인 파트(＠ 이후)는 특수문자로 시작하면 안 됩니다.
    /// - 최상위 도메인(TLD)은 2자 이상, 6자 이하의 영문자로 구성되어야 합니다.
    ///
    /// ## 정규 표현식(Regular Expression)
    /// 문자열은 아래 정규 표현식으로 유효한 이메일 주소인지 판단합니다.
    ///
    /// > Regular Expression: ^[A-Za-z0-9](?:[A-Za-z0-9._%+-=]*[A-Za-z0-9])@[A-Za-z0-9](?:[A-Za-z0-9]*[A-Za-z0-9])?(?:\.[A-Za-z]{2,6})+$
    ///
    /// * **`^[A-Za-z0-9]`**: 로컬 파트의 첫 글자는 영문자(대소문자)와 숫자만 허용하며, 특수문자로 시작할 수 없습니다.
    /// * **`(?:[A-Za-z0-9._%+-=]*[A-Za-z0-9])`**: 이후에는 영문자, 숫자, 특수문자(`._%+-=`)가 0개 이상 올 수 있습니다. 단, 마지막 문자는 반드시 영문자 또는 숫자여야 합니다. 이 그룹은 논캡처 그룹(non-capturing group)입니다.
    /// * **`@`**: 이메일 구분자 `@` 기호입니다.
    /// * **`[A-Za-z0-9]`**: 도메인의 첫 글자는 영문자 또는 숫자여야 하며, 특수문자로 시작할 수 없습니다.
    /// * **`(?:[A-Za-z0-9]*[A-Za-z0-9])?`**: 도메인의 나머지 부분에서는 영문자와 숫자가 포함될 수 있으며, 마지막 문자 역시 영문자 또는 숫자여야 합니다. 이 그룹은 선택적이며, 논캡처 그룹입니다.
    /// * **`(?:\.[A-Za-z]{2,6})`**: 최상위 도메인(TLD)은 점(`.`)으로 시작하며, 이어서 2~6자의 영문자(대소문자)가 와야 합니다.
    ///
    /// > Important: `"john.doe123@sub.example.co.uk"`처럼 도메인에 `.`이 여러 번 포함된 경우, 현재 정규식 패턴으로는 정확하게 일치하지 않을 수 있습니다.
    var checkIsVaildEmailAddress: Bool {
        let pattern = #"^[A-Za-z0-9](?:[A-Za-z0-9._%+-=]*[A-Za-z0-9])@[A-Za-z0-9](?:[A-Za-z0-9]*[A-Za-z0-9])?(?:\.[A-Za-z]{2,10})+$"#
        return patternWholeMatching(self, pattern: pattern)
    }
    
    /// 정규 표현식을 사용하여 비밀번호가 유효한지 판단합니다.
    ///
    /// 유효한 비밀번호가 되기 위해서는 다음 조건을 모두 충족해야 합니다:
    /// - 길이는 6자 이상, 20자 이하여야 합니다.
    /// - 영문 대문자 또는 소문자를 최소 1자 이상 포함해야 합니다.
    /// - 숫자(0~9)를 최소 1자 이상 포함해야 합니다.
    /// - 특수문자(!@#$%^&*-+=?)를 최소 1자 이상 포함해야 합니다.
    ///
    /// ## 정규 표현식(Regular Expression)
    /// 문자열은 아래 정규 표현식으로 유효한 비밀번호인지 판단합니다.
    ///
    /// > Regular Expression: ^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*-+=?])[A-Za-z0-9!@#$%^&*-+=?]{6,20}$
    ///
    /// * **(?=.*[a-z])**: 긍정 전방 탐색(Positive Lookahead), 소문자 왼쪽에 위치한 문자열을 탐색하며, 소문자는 소비하지 않습니다. 즉, 소문자를 최소 1자 이상 포함해야 합니다.
    /// * **(?=.*[A-Z])**: 긍정 전방 탐색(Positive Lookahead), 대문자 왼쪽에 위치한 문자열을 탐색하며, 대문자는 소비하지 않습니다. 즉, 대문자를 최소 1자 이상 포함해야 합니다.
    /// * **(?=.*[!@#$%^&*-+=?])**: 긍정 전방 탐색 (Positive Lookahead), 특수문자 왼쪽에 위치한 문자열을 탐색하며, 특수문자는 소비하지 않습니다. 즉, 특수문자를 최소 1자 이상 포함해야 합니다.
    /// * **(?=.*[0-9])**: 긍전 전방 탐색(Positive Lookahead),  숫자 왼쪽에 위치한 문자열을 탐색하며, 숫자를 소비하지 않습니다. 즉, 숫자를 최소 1자 이상 포함해야 합니다.
    /// * **[A-Za-z0-9!@#$%^&*-+=?]{6,20}**: 대소문자, 숫자와 특수문자의 길이가 6자 이상, 20자 이하여야 합니다.
    ///
    var checkIsValidPassword: Bool {
        let pattern = #"^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*-+=?])(?=.*[0-9])[A-Za-z0-9!@#$%^&*-+=?]{6,20}$"#
        return patternWholeMatching(self, pattern: pattern)
    }
    
    /// 주어진 문자열이 정규 표현식 패턴과 전체적으로 일치하는지 여부를 반환합니다.
    ///
    /// - Parameters:
    ///   - string: 검사할 대상 문자열입니다.
    ///   - pattern: 검사에 사용할 정규 표현식 패턴 문자열입니다.
    /// - Returns: 문자열이 패턴과 정확히 일치하면 `true`, 그렇지 않으면 `false`를 반환합니다.
    func patternWholeMatching(
        _ string: String,
        pattern: String
    ) -> Bool {
        guard !string.isEmpty else { return false }
        
        guard
            let pattern = try? NSRegularExpression(pattern: pattern)
        else { return false }
        let nsrange = NSRange(string.startIndex... , in: string)
        guard
            let match = pattern.firstMatch(in: string, range: nsrange)
        else { return false }
        return match.range == nsrange
    }
}
